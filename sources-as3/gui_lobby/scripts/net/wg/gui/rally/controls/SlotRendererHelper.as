package net.wg.gui.rally.controls
{
   import flash.display.InteractiveObject;
   import net.wg.data.constants.Values;
   import net.wg.gui.rally.controls.interfaces.IRallySimpleSlotRenderer;
   import net.wg.gui.rally.controls.interfaces.ISlotRendererHelper;
   import net.wg.gui.rally.interfaces.IRallySlotVO;
   import net.wg.infrastructure.interfaces.IUserProps;
   
   public class SlotRendererHelper implements ISlotRendererHelper
   {
      
      private static const MSG_NOT_VALID_TYPE_CAST:String = "Specified cast is not valid ";
       
      
      private var _chooseVehicleText:String = "#cyberSport:button/medallion/chooseVehicle";
      
      public function SlotRendererHelper()
      {
         super();
      }
      
      public function initControlsState(param1:IRallySimpleSlotRenderer) : void
      {
         var _loc2_:RallySimpleSlotRenderer = param1 as RallySimpleSlotRenderer;
         App.utils.asserter.assertNotNull(_loc2_,MSG_NOT_VALID_TYPE_CAST + RallySimpleSlotRenderer);
         _loc2_.slotLabel.text = Values.EMPTY_STR;
      }
      
      public function onControlRollOver(param1:InteractiveObject, param2:IRallySimpleSlotRenderer, param3:IRallySlotVO, param4:* = null) : void
      {
         var _loc5_:RallySimpleSlotRenderer = param2 as RallySimpleSlotRenderer;
         App.utils.asserter.assertNotNull(_loc5_,MSG_NOT_VALID_TYPE_CAST + RallySimpleSlotRenderer);
         if(param1 == _loc5_.contextMenuArea && param3 && param3.player)
         {
            App.toolTipMgr.show(param3.player.getToolTip());
         }
      }
      
      public function updateComponents(param1:IRallySimpleSlotRenderer, param2:IRallySlotVO) : void
      {
         var _loc3_:RallySimpleSlotRenderer = RallySimpleSlotRenderer(param1);
         if(param2 != null)
         {
            if(param2.player)
            {
               this.formatPlayerName(_loc3_,param2);
               if(_loc3_.contextMenuArea)
               {
                  _loc3_.contextMenuArea.width = _loc3_.slotLabel.width;
               }
            }
            else
            {
               _loc3_.setSlotLabelHtmlText(param2.slotLabel);
            }
         }
      }
      
      protected function formatPlayerName(param1:IRallySimpleSlotRenderer, param2:IRallySlotVO) : void
      {
         var _loc3_:IUserProps = App.utils.commons.getUserProps(param2.player.userName,param2.player.clanAbbrev,param2.player.region,param2.player.igrType,param2.player.tags);
         _loc3_.rgb = param2.player.color;
         param1.formatPlayerName(_loc3_);
      }
      
      protected function isShowSlotRestrictions(param1:RallySimpleSlotRenderer, param2:IRallySlotVO) : Boolean
      {
         return param1.index != 0 && param2.hasRestrictions;
      }
      
      public function get chooseVehicleText() : String
      {
         return this._chooseVehicleText;
      }
      
      public function set chooseVehicleText(param1:String) : void
      {
         this._chooseVehicleText = param1;
      }
      
      public final function dispose() : void
      {
         this.onDispose();
      }
      
      protected function onDispose() : void
      {
      }
   }
}
