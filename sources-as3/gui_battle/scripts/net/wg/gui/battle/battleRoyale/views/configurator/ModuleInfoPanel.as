package net.wg.gui.battle.battleRoyale.views.configurator
{
   import flash.display.Sprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class ModuleInfoPanel extends Sprite implements IDisposable
   {
       
      
      public var module:ModuleInfo = null;
      
      public function ModuleInfoPanel()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this.module.dispose();
         this.module = null;
      }
   }
}
