package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.components.BattleDisplayable;
   
   public class VehicleSelectionMeta extends BattleDisplayable
   {
       
      
      public var setSelectionParams:Function;
      
      public var handleRightMouseBtn:Function;
      
      public var handleMouseOverUI:Function;
      
      public var handleMouseWheel:Function;
      
      public function VehicleSelectionMeta()
      {
         super();
      }
      
      public function setSelectionParamsS(param1:int, param2:int, param3:int, param4:int, param5:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.setSelectionParams,"setSelectionParams" + Errors.CANT_NULL);
         this.setSelectionParams(param1,param2,param3,param4,param5);
      }
      
      public function handleRightMouseBtnS() : void
      {
         App.utils.asserter.assertNotNull(this.handleRightMouseBtn,"handleRightMouseBtn" + Errors.CANT_NULL);
         this.handleRightMouseBtn();
      }
      
      public function handleMouseOverUIS(param1:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.handleMouseOverUI,"handleMouseOverUI" + Errors.CANT_NULL);
         this.handleMouseOverUI(param1);
      }
      
      public function handleMouseWheelS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.handleMouseWheel,"handleMouseWheel" + Errors.CANT_NULL);
         this.handleMouseWheel(param1);
      }
   }
}
