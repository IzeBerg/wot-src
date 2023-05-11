package net.wg.gui.lobby.tankman
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.events.PersonalCaseEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   
   public class PersonalCaseCommanderFeature extends UIComponentEx
   {
      
      private static const SIXTH_SENSE:String = "commander_sixthSense";
      
      private static const SKILL_LEVEL:uint = 100;
       
      
      public var commanderFeature:TextField;
      
      public var sixthSense:TextField;
      
      public var sixthSenseIcon:Sprite;
      
      private var _toolTipMgr:ITooltipMgr;
      
      private var _tankmanID:int = -1;
      
      public function PersonalCaseCommanderFeature()
      {
         this._toolTipMgr = App.toolTipMgr;
         super();
         this.commanderFeature.autoSize = TextFieldAutoSize.LEFT;
         this.sixthSense.autoSize = TextFieldAutoSize.RIGHT;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
         var _loc1_:PersonalCaseEvent = new PersonalCaseEvent(PersonalCaseEvent.GET_TANKMAN_ID,true);
         _loc1_.tankmanIdDelegate = this.getTankmanID;
         dispatchEvent(_loc1_);
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
         this.commanderFeature = null;
         this.sixthSense = null;
         this.sixthSenseIcon = null;
         this._toolTipMgr.hide();
         this._toolTipMgr = null;
         super.onDispose();
      }
      
      private function getTankmanID(param1:int) : void
      {
         this._tankmanID = param1;
      }
      
      private function onMouseOverHandler(param1:MouseEvent) : void
      {
         if(!this.enabled)
         {
            return;
         }
         this._toolTipMgr.showWulfTooltip(TOOLTIPS_CONSTANTS.CREW_PERK_GF,SIXTH_SENSE,this._tankmanID,SKILL_LEVEL);
      }
      
      private function onMouseOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
   }
}
