package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.components.BattleDisplayable;
   
   public class MinimapMeta extends BattleDisplayable
   {
       
      
      public var onMinimapClicked:Function;
      
      public var applyNewSize:Function;
      
      public function MinimapMeta()
      {
         super();
      }
      
      public function onMinimapClickedS(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         App.utils.asserter.assertNotNull(this.onMinimapClicked,"onMinimapClicked" + Errors.CANT_NULL);
         this.onMinimapClicked(param1,param2,param3,param4);
      }
      
      public function applyNewSizeS(param1:Number) : void
      {
         App.utils.asserter.assertNotNull(this.applyNewSize,"applyNewSize" + Errors.CANT_NULL);
         this.applyNewSize(param1);
      }
   }
}
