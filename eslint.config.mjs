// @ts-check
import eslint from '@eslint/js';
import eslintPluginPrettierRecommended from 'eslint-plugin-prettier/recommended';
import globals from 'globals';
import tseslint from 'typescript-eslint';

export default tseslint.config(
  {
    ignores: ['eslint.config.mjs', 'dist'], // Added dist to ignores
  },
  eslint.configs.recommended,
  ...tseslint.configs.recommendedTypeChecked,
  eslintPluginPrettierRecommended,
  {
    languageOptions: {
      globals: {
        ...globals.node,
        ...globals.jest,
      },
      sourceType: 'commonjs',
      parserOptions: {
        project: true, // Ensure project is true for type-aware linting
        tsconfigRootDir: import.meta.dirname,
      },
    },
  },
  {
    // General rules
    rules: {
      '@typescript-eslint/no-explicit-any': 'off',
      '@typescript-eslint/no-floating-promises': 'warn',
      '@typescript-eslint/no-unsafe-argument': 'warn',
      '@typescript-eslint/no-unsafe-return': 'warn',
      // It's possible no-unsafe-call is the one causing issues with decorators
      // If problems persist, we might set this to 'warn' or 'off' globally,
      // or specifically for DTOs as shown in the override below.
      // '@typescript-eslint/no-unsafe-call': 'warn',
    },
  },
  {
    // Override for DTO files to relax rules on decorator usage
    files: ['src/**/*.dto.ts'],
    rules: {
      '@typescript-eslint/no-unsafe-call': 'off', // Allow unsafe calls (decorators)
      '@typescript-eslint/no-unsafe-assignment': 'off', // May also be relevant for DTOs
      '@typescript-eslint/no-unsafe-member-access': 'off', // May also be relevant
    },
  },
);
