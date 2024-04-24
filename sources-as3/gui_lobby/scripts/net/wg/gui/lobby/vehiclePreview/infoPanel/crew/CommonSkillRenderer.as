package net.wg.gui.lobby.vehiclePreview.infoPanel.crew
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.controls.Image;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import scaleform.clik.constants.InvalidationType;
   
   public class CommonSkillRenderer extends UIComponentEx
   {
      
      private static const SKILL_LEVEL:uint = 100;
       
      
      public var icon:Image = null;
      
      public var commentTF:TextField = null;
      
      private var _data:VPCrewTabVO;
      
      private var _toolTipMgr:ITooltipMgr;
      
      public function CommonSkillRenderer()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.icon.removeEventListener(Event.CHANGE,this.onIconChangeHandler);
         this.icon.dispose();
         this.icon = null;
         this.commentTF = null;
         this._data = null;
         this._toolTipMgr = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._toolTipMgr = App.toolTipMgr;
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.icon.addEventListener(Event.CHANGE,this.onIconChangeHandler);
         this.commentTF.autoSize = TextFieldAutoSize.LEFT;
         this.commentTF.wordWrap = true;
         this.commentTF.multiline = true;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.commentTF.y = this.icon.height - this.commentTF.height >> 1;
            this.commentTF.width = width - this.commentTF.x;
         }
      }
      
      public function setData(param1:VPCrewTabVO) : void
      {
         this._data = param1;
         this.icon.source = param1.skillIcon;
         this.commentTF.htmlText = param1.vehicleCrewComment;
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         if(this._data.skillName)
         {
            this._toolTipMgr.showWulfTooltip(TOOLTIPS_CONSTANTS.CREW_PERK_GF,this._data.skillName,null,SKILL_LEVEL,null,null,null,this._data.skillCustomisation);
         }
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
      
      private function onIconChangeHandler(param1:Event) : void
      {
         dispatchEvent(param1);
         invalidateSize();
      }
   }
}
