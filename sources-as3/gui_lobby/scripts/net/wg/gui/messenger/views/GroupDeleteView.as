package net.wg.gui.messenger.views
{
   import flash.display.InteractiveObject;
   import flash.text.TextField;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.messenger.meta.IGroupDeleteViewMeta;
   import net.wg.gui.messenger.meta.impl.GroupDeleteViewMeta;
   import scaleform.clik.constants.InvalidationType;
   
   public class GroupDeleteView extends GroupDeleteViewMeta implements IGroupDeleteViewMeta
   {
       
      
      public var groupNameLabel:TextField;
      
      public var cbDeleteWithMembers:CheckBox;
      
      private var groupName:Object;
      
      public function GroupDeleteView()
      {
         super();
      }
      
      override public function getComponentForFocus() : InteractiveObject
      {
         return this.cbDeleteWithMembers;
      }
      
      override public function getFocusChain() : Vector.<InteractiveObject>
      {
         return new <InteractiveObject>[this.cbDeleteWithMembers].concat(super.getFocusChain());
      }
      
      override public function onOkS(param1:Object) : void
      {
         var _loc2_:Object = {
            "groupName":this.groupName,
            "deleteWithMembers":this.cbDeleteWithMembers.selected
         };
         super.onOkS(_loc2_);
      }
      
      override public function update(param1:Object) : void
      {
         super.update(param1);
         if(param1)
         {
            this.groupName = param1.toString();
            invalidateData();
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.cbDeleteWithMembers.label = App.utils.locale.makeString(MESSENGER.MESSENGER_CONTACTS_VIEW_MANAGEGROUP_DELETEGROUP_DELETEWITHMEMBERS_LABEL);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA) && this.groupName)
         {
            this.groupNameLabel.text = App.utils.locale.makeString(MESSENGER.MESSENGER_CONTACTS_VIEW_MANAGEGROUP_DELETEGROUP_GROUPNAME_LABEL,{"groupName":this.groupName});
         }
      }
      
      override protected function onDispose() : void
      {
         super.onDispose();
      }
   }
}
