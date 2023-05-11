package net.wg.gui.battle.views.minimap.components.entries.battleRoyale
{
   import flash.display.Sprite;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.managers.IAtlasManager;
   import net.wg.infrastructure.managers.IColorSchemeManager;
   import scaleform.clik.motion.Tween;
   
   public class DiscoveredItemMarker extends Sprite implements IDisposable
   {
      
      private static const DELAY_MAX_TIE_MS:int = 500;
       
      
      private var _fadeInTween:Tween = null;
      
      private var _fadeOutTween:Tween = null;
      
      private var _atlasMgr:IAtlasManager;
      
      private var _img:String = "";
      
      private var _colorSchMgr:IColorSchemeManager;
      
      private var _disposed:Boolean = false;
      
      public function DiscoveredItemMarker()
      {
         this._atlasMgr = App.atlasMgr;
         this._colorSchMgr = App.colorSchemeMgr;
         super();
         alpha = 0;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.clearTweens();
         this._atlasMgr = null;
         this._colorSchMgr = null;
      }
      
      public function hide(param1:Number) : void
      {
         this.clearTweens();
         this._fadeOutTween = new Tween(param1,this,{"alpha":0});
         this._fadeOutTween.paused = false;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function show(param1:String, param2:Number, param3:String = "") : void
      {
         this.updateIcon(param1,param3);
         this.clearTweens();
         this._fadeInTween = new Tween(param2,this,{"alpha":1});
         this._fadeInTween.delay = DELAY_MAX_TIE_MS * Math.random();
         this._fadeInTween.paused = false;
      }
      
      public function updateIcon(param1:String, param2:String = "") : void
      {
         if(this._img != param1)
         {
            this._img = param1;
            this._atlasMgr.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,param1,this.graphics,"",false,false,true);
            if(param2.length > 0)
            {
               transform.colorTransform = this._colorSchMgr.getTransform("vm_" + param2);
            }
         }
      }
      
      private function clearTweens() : void
      {
         if(this._fadeInTween)
         {
            this._fadeInTween.paused = true;
            this._fadeInTween.dispose();
            this._fadeInTween = null;
         }
         if(this._fadeOutTween)
         {
            this._fadeOutTween.paused = true;
            this._fadeOutTween.dispose();
            this._fadeOutTween = null;
         }
      }
   }
}
