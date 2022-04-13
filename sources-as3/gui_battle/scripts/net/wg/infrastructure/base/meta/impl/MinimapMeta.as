package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.components.BattleDisplayable;
   
   public class MinimapMeta extends BattleDisplayable
   {
       
      
      public var onMinimapClicked:Function;
      
      public var applyNewSize:Function;
      
      public var handleMouseOverUIMinimap:Function;
      
      public var onHoverEntry:Function;
      
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
      
      public function handleMouseOverUIMinimapS(param1:Number) : void
      {
         App.utils.asserter.assertNotNull(this.handleMouseOverUIMinimap,"handleMouseOverUIMinimap" + Errors.CANT_NULL);
         this.handleMouseOverUIMinimap(param1);
      }
      
      public function onHoverEntryS(param1:Number) : void
      {
         App.utils.asserter.assertNotNull(this.onHoverEntry,"onHoverEntry" + Errors.CANT_NULL);
         this.onHoverEntry(param1);
      }
   }
}
