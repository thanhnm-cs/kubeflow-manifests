

# kubectl get pod --all-namespaces --sort-by='.metadata.name' -o json | jq -r '[.items[] | {ns: .metadata.namespace, containers: .spec.containers[] | [ {container_name: .name, memory_requested: .resources.requests.memory,memory_limits: .resources.limits.memory, cpu_requested: .resources.requests.cpu,cpu_limits: .resources.limits.cpu } ] }]' | jq  'sort_by(.containers[0].cpu_requested)' | jq  'sort_by(.ns)' |
# kubectl get deployment,statefulset --all-namespaces --sort-by='.metadata.name' -o json | jq -r '[.items[] | {kind: .kind,name:.metadata.name, ns: .metadata.namespace,state: .status.phase,rep: .spec.replicas, containers: .spec.template.spec.containers[] | [ {cpu_requested: .resources.requests.cpu,cpu_limits: .resources.limits.cpu,memory_requested: .resources.requests.memory,memory_limits: .resources.limits.memory } ] }]' | jq  'sort_by(.containers[0].cpu_requested)' | jq  'sort_by(.ns)' | \
# python3 -c "
# import json,sys
# from sympy.parsing.sympy_parser import parse_expr,implicit_multiplication_application,standard_transformations,factorial_notation
# transformations = (standard_transformations + (implicit_multiplication_application,)+(factorial_notation,))

# a=json.loads(sys.stdin.read())
# memory_requested='0'
# memory_limits='0'
# cpu_requested='0'
# cpu_limits='0'
# for i in a:
#     print(i['ns'],'\t',i['kind']+'/'+i['name'],'\t',i['rep'],end='\t')
#     for ik,iv in i['containers'][0].items():
#         print(iv,end='\t')
#         if ik == 'memory_requested' and iv:
#             memory_requested=parse_expr(str(iv) +'+'+ str(memory_requested),transformations=transformations)
#         if ik == 'memory_limits' and iv:
#             memory_limits=parse_expr(str(iv) +'+'+ str(memory_limits),transformations=transformations)
#         if ik == 'cpu_requested' and iv:
#             cpu_requested=parse_expr(str(iv) +'+'+ str(cpu_requested),transformations=transformations)
#         if ik == 'cpu_limits' and iv:
#             cpu_limits=parse_expr(str(iv) +'+'+ str(cpu_limits),transformations=transformations)
#     print('\n')
# #print(memory_requested.subs('i','1000/1024').evalf(),memory_limits.subs('i',1).subs('M','G*(1/1024)').evalf(),cpu_requested,cpu_limits,sep='\n')
# print(memory_requested.subs('i','1000/1024').evalf(),memory_limits.subs('i',1).subs('M','G*(1/1024)').evalf(),cpu_requested.subs('m','0.001').evalf(),cpu_limits.subs('m','0.001').evalf(),sep='\n')
# "

kubectl get svc --all-namespaces --sort-by='.metadata.labels.app' -o json | jq -r '[.items[] | {app: .metadata.labels.app,name: .metadata.name,type:.spec.type}]' | jq -r '.[] | "\(.app)\/\(.type)\/\(.name)\t"'