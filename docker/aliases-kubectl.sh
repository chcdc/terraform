alias kg='kubectl get'
alias kd='kubectl describe'
alias ke='kubectl edit'

alias kgss='kubectl get statefulset'
alias kdss='kubectl describe statefulset'

alias kgnp='kubectl get networkpolicy'
alias kdnp='kubectl describe networkpolicy'

alias kgpv='kubectl get pv'
alias kdpv='kubectl describe pv'

alias kgpvc='kubectl get pvc'
alias kdpvc='kubectl describe pvc'

alias kgsa='kubectl get serviceaccount'
alias kgsa='kubectl describe serviceaccount'

alias kdelpforce='kubectl delete pod --grace-period=0 --force'

alias kge='kubectl get events --sort-by="{.lastTimestamp}"'

alias krolld='kubectl set env --env="LAST_MANUAL_ROLLING_RESTART=$(date --utc --iso-8601=seconds)" deployment'
alias krollss='kubectl set env --env="LAST_MANUAL_ROLLING_RESTART=$(date --utc --iso-8601=seconds)" statefulset'

alias wkgp='watch -n 1 kubectl get pods'
alias wkgpw='watch -n 1 kubectl get pods --output wide'
alias wkgpall='watch -n 1 kubectl get pods --all-namespaces --field-selector metadata.namespace!=kube-system'
alias wkgpwall='watch -n 1 kubectl get pods --all-namespaces --field-selector metadata.namespace!=kube-system --output wide'
