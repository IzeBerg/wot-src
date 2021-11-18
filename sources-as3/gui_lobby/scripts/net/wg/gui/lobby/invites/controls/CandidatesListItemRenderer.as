package net.wg.gui.lobby.invites.controls
{
   import flash.events.MouseEvent;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import net.wg.gui.messenger.controls.ContactItem;
   import net.wg.gui.messenger.data.ContactItemVO;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.InputEvent;
   
   public class CandidatesListItemRenderer extends SoundListItemRenderer
   {
       
      
      private var _contactItem:ContactItem = null;
      
      private var _myData:ContactItemVO = null;
      
      public function CandidatesListItemRenderer()
      {
         constraintsDisabled = true;
         super();
      }
      
      override public function getData() : Object
      {
         return this._myData;
      }
      
      override public function setData(param1:Object) : void
      {
         this._myData = param1 != null ? ContactItemVO(param1) : null;
         invalidateData();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            if(this._myData != null)
            {
               visible = true;
               if(this._contactItem == null)
               {
                  this._contactItem = App.utils.classFactory.getComponent(Linkages.CONTACT_ITEM_UI,ContactItem);
                  this._contactItem.width = _width / scaleX;
                  this._contactItem.height = _height / scaleY;
                  addChild(this._contactItem);
               }
               this._contactItem.update(this._myData);
               if(hitTestPoint(App.stage.mouseX,App.stage.mouseY))
               {
                  this.updateToolTip();
               }
            }
            else
            {
               visible = false;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         if(this._contactItem != null)
         {
            this._contactItem.dispose();
            this._contactItem = null;
         }
         this._myData = null;
         super.onDispose();
      }
      
      private function updateToolTip() : void
      {
         if(this._myData != null && this._myData.userPropsVO != null)
         {
            App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.CONTACT,null,this._myData.dbID,App.utils.commons.getFullPlayerName(this._myData.userPropsVO));
         }
      }
      
      [Inspectable(defaultValue="",type="string")]
      override public function get data() : Object
      {
         return this._myData;
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
      }
      
      override protected function handleMouseRollOver(param1:MouseEvent) : void
      {
         super.handleMouseRollOver(param1);
         this.updateToolTip();
      }
      
      override protected function handleMouseRollOut(param1:MouseEvent) : void
      {
         super.handleMouseRollOut(param1);
         App.toolTipMgr.hide();
      }
   }
}
