# Set internal registry operator to managed state
oc patch configs.imageregistry.operator.openshift.io cluster --type merge --patch '{"spec":{"managementState":"Managed"}}'

# Configure storage for resgistry
oc patch configs.imageregistry.operator.openshift.io cluster --type merge --patch '{"spec":{"storage":{"pvc":{"claim":""}}}}'

# Expose internal registry
oc patch configs.imageregistry.operator.openshift.io cluster --type merge --patch '{"spec":{"defaultRoute":true}}'
