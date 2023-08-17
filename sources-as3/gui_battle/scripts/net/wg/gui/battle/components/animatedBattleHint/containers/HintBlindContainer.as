package net.wg.gui.battle.components.animatedBattleHint.containers
{
   import flash.display.MovieClip;
   import net.wg.data.constants.ColorSchemeNames;
   import net.wg.infrastructure.events.ColorSchemeEvent;
   import net.wg.infrastructure.interfaces.IColorScheme;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class HintBlindContainer extends MovieClip implements IDisposable
   {
       
      
      public var blindMc:MovieClip = null;
      
      private var _disposed:Boolean = false;
      
      public function HintBlindContainer()
      {
         super();
         App.colorSchemeMgr.addEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemasUpdatedHandler);
         this.updateAnimationContainer();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         App.colorSchemeMgr.removeEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemasUpdatedHandler);
         this.blindMc = null;
      }
      
      private function updateAnimationContainer() : void
      {
         var _loc1_:IColorScheme = App.colorSchemeMgr.getScheme(ColorSchemeNames.RED_PURPLE_SCHEMA);
         this.blindMc.gotoAndStop(_loc1_.aliasColor);
      }
      
      private function onColorSchemasUpdatedHandler(param1:ColorSchemeEvent) : void
      {
         this.updateAnimationContainer();
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
