# GitHub Actions Workflow Configuration
# RSU Delima Hospital Management App

This directory contains GitHub Actions workflows for the RSU Delima project.

## Workflows Overview

### 1. CI/CD Pipeline (`ci-cd.yml`)
**Triggers:** Push to main/develop, Pull Requests, Releases
- **Code Analysis & Testing**: Static analysis, formatting checks, unit tests
- **Multi-platform Builds**: Android (APK/AAB), iOS, Web, Windows
- **Performance Analysis**: App size analysis for PRs
- **Security Scanning**: Vulnerability scanning with Trivy
- **Release Notifications**: Automated release completion notifications
- **Artifact Management**: Uploads build artifacts with retention policies

### 2. Scheduled Maintenance (`maintenance.yml`)
**Triggers:** Weekly schedule (Mondays), Manual dispatch
- **Dependency Updates**: Automated Flutter dependency upgrades
- **Health Checks**: Repository health monitoring and reporting
- **Performance Benchmarks**: Regular performance metric collection
- **Issue Creation**: Automated maintenance issue creation

### 3. Pull Request Automation (`pr-automation.yml`)
**Triggers:** PR events, PR reviews
- **Auto-labeling**: Intelligent PR labeling based on changes
- **Quality Checks**: PR quality assessment and reporting
- **Auto-merge**: Automated merging for approved dependency updates
- **Changelog Updates**: Automatic changelog maintenance

### 4. Release Management (`release.yml`)
**Triggers:** Git tags (v*), Manual dispatch
- **Release Creation**: Automated GitHub releases with changelogs
- **Multi-platform Assets**: Builds and uploads release assets for all platforms
- **Release Notes**: Automated changelog generation
- **Notifications**: Team notifications for new releases

## Required Secrets

To fully utilize these workflows, configure the following secrets in your GitHub repository:

### Required
- `GITHUB_TOKEN` (automatically provided by GitHub)

### Optional (for enhanced features)
- `SLACK_WEBHOOK_URL`: For Slack notifications (if added)

## Workflow Features

### Performance Optimizations
- **Caching**: Flutter SDK and dependency caching across jobs
- **Parallel Execution**: Multiple platform builds run concurrently
- **Conditional Execution**: Jobs only run when necessary
- **Artifact Cleanup**: Automated cleanup of old artifacts

### Security Features
- **Code Scanning**: Trivy vulnerability scanner
- **Dependency Auditing**: Regular dependency health checks
- **Obfuscation**: Release builds use code obfuscation
- **Split Debug Info**: Debug symbols separated for security

### Developer Experience
- **Auto-labeling**: PRs automatically labeled based on changes
- **Quality Reports**: Comprehensive PR quality assessments
- **Size Analysis**: App size tracking and PR comments
- **Health Monitoring**: Weekly repository health reports

### Deployment Strategy
- **Release Assets**: Automatic generation of platform-specific builds for releases
- **Multi-platform**: Supports Android, iOS, Web, and Windows build artifacts
- **Manual Distribution**: Built artifacts are available for manual deployment
- **Rollback**: Easy rollback capabilities with release management

## Platform-Specific Notes

### Android
- Uses ProGuard for code shrinking and obfuscation
- Generates both APK and App Bundle (AAB) for different distribution channels
- Supports multi-architecture builds

### iOS
- Builds without code signing for CI/CD
- Generates Xcode archives for distribution
- Requires macOS runners for building

### Web
- Uses HTML renderer for better compatibility
- Optimized for production deployment
- Generates static web assets for manual deployment

### Windows
- Generates zip packages for distribution
- Uses Windows runners for native compilation
- Includes all required dependencies

## Monitoring and Alerts

### Build Status
- All workflows report status to GitHub checks
- Failed builds automatically create issues (when configured)
- Slack/Discord notifications for critical failures

### Performance Tracking
- App size tracking across releases
- Build time monitoring
- Local test coverage generation

### Security Monitoring
- Vulnerability scanning on every push to main
- Dependency security alerts
- Automated security patches for dependencies

## Best Practices

### Branch Protection
Configure branch protection rules for `main` branch:
- Require status checks to pass
- Require branches to be up to date
- Require linear history
- Include administrators in restrictions

### Review Process
- All PRs require at least one review
- Automated checks must pass before merge
- Security-related changes require additional review

### Release Process
1. Create a new tag following semantic versioning (e.g., `v1.2.3`)
2. Push the tag to trigger release workflow
3. Review and publish the automatically created release
4. Monitor deployment status and health checks

## Troubleshooting

### Common Issues
1. **Flutter SDK Cache Issues**: Clear runner cache in Actions settings
2. **Build Failures**: Check Flutter version compatibility
3. **Test Failures**: Ensure all dependencies are correctly specified
4. **Deploy Failures**: Verify all required secrets are configured

### Debug Steps
1. Enable runner debug logging for detailed output
2. Check individual job logs for specific error messages
3. Verify all required secrets and environment variables
4. Test workflows in a fork before applying to main repository

## Customization

These workflows can be customized for your specific needs:

1. **Modify trigger conditions** in the `on:` sections
2. **Add additional platforms** by extending the build matrix
3. **Integrate additional tools** by adding new workflow steps
4. **Configure notifications** by adding webhook integrations
5. **Adjust retention policies** for artifacts and logs

For more information about GitHub Actions, visit the [official documentation](https://docs.github.com/en/actions).
