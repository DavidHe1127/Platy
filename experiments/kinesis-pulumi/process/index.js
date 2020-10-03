const aws = require('@pulumi/aws');
const pulumi = require('@pulumi/pulumi');

const lambdaRole = new aws.iam.Role('my-lambda-role', {
  name: 'sample-role',
  assumeRolePolicy: aws.iam.assumeRolePolicyForPrincipal({
    Service: 'lambda.amazonaws.com',
  }),
});

// 1st arg - The unique name of the resource
const lambda = new aws.lambda.Function('data-handling-func', {
  name: 'dockerzon-data-handler',
  runtime: 'nodejs12.x',
  timeout: 900,
  role: lambdaRole.arn,
  handler: 'index.handler',
  memorySize: 1024,
  code: new pulumi.asset.AssetArchive({
    '.': new pulumi.asset.FileArchive('./func'),
  }),
  environment: {
    variables: {
      DESTROY_ENABLED: 'true',
    },
  },
});
