package net.wg.gui.battle.views.radialMenu.components
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class SectorHoveredWrapper extends Sprite implements IDisposable
   {
       
      
      public var content:Content = null;
      
      public var light:MovieClip = null;
      
      private var _disposed:Boolean = false;
      
      public function SectorHoveredWrapper()
      {
         super();
      }
      
      public function setLightState(param1:String) : void
      {
         this.light.hoverEffect.hoverEffectColor.gotoAndStop(param1);
         this.light.hoverEffectWithShadow.hoverEffectWithShadowColor.gotoAndStop(param1);
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.content.dispose();
         this.content = null;
         this.light = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
