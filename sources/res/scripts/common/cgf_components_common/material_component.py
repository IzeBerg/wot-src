import CGF
from cgf_script.component_meta_class import ComponentProperty, CGFMetaTypes, registerComponent

@registerComponent
class MaterialComponent(object):
    category = 'Material'
    editorTitle = 'Material'
    domain = CGF.DomainOption.DomainAll
    kind = ComponentProperty(type=CGFMetaTypes.STRING, editorName='Kind', value='', annotations={'comboBox': {'ground': 'ground', 'stone': 'stone', 
                    'wood': 'wood', 
                    'metal': 'metal', 
                    'snow': 'snow', 
                    'sand': 'sand', 
                    'water': 'water', 
                    'dirt': 'dirt', 
                    'oil': 'oil'}})