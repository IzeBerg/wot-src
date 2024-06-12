package net.wg.gui.battle.views.epicDeploymentMap.components
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import net.wg.gui.battle.views.epicDeploymentMap.events.EpicDeploymentMapEvent;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.gfx.MouseEventEx;
   
   public class EpicMapContainer extends MovieClip implements IDisposable
   {
       
      
      public var mapHit:MovieClip = null;
      
      public var mapMask:MovieClip = null;
      
      public var entriesContainer:EpicDeploymentMapEntriesContainer = null;
      
      private var _clickAreaSpr:Sprite = null;
      
      private var _disposed:Boolean = false;
      
      public function EpicMapContainer()
      {
         super();
         this._clickAreaSpr = new Sprite();
         addChildAt(this._clickAreaSpr,getChildIndex(this.mapHit));
         this.mapHit.visible = true;
         this._clickAreaSpr.hitArea = this.mapHit;
         this.entriesContainer.mouseEnabled = this.entriesContainer.mouseChildren = false;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this._clickAreaSpr.removeEventListener(MouseEvent.CLICK,this.onMouseClickHandler);
         this._clickAreaSpr = null;
         this.mapHit = null;
         this.mapMask = null;
         this.entriesContainer.dispose();
         this.entriesContainer = null;
      }
      
      public function initializeMouseHandler() : void
      {
         this._clickAreaSpr.addEventListener(MouseEvent.CLICK,this.onMouseClickHandler);
      }
      
      private function onMouseClickHandler(param1:MouseEvent) : void
      {
         if(param1 is MouseEventEx && param1.target == this._clickAreaSpr)
         {
            if(this.mapHit.mouseX < 0 || this.mapHit.mouseY < 0 || this.mapHit.mouseX > this.width || this.mapHit.mouseY > this.height)
            {
               return;
            }
            dispatchEvent(new EpicDeploymentMapEvent(EpicDeploymentMapEvent.MAP_CLICKED,this.mapHit.mouseX,this.mapHit.mouseY,MouseEventEx(param1).buttonIdx));
         }
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
