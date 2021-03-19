{
   "apiVersion": "v1",
   "kind": "PersistentVolumeClaim",
   "metadata": {
     "name": "registry-pvc-ocs"
   },
   "spec": {
     "storageClassName": "ocs-storagecluster-cephfs",
     "accessModes": [ "ReadWriteMany" ],
     "resources": {
       "requests": { "storage": "100Gi"
     }
   }
 }
}
