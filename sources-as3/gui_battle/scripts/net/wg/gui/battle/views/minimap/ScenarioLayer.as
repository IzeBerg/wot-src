package net.wg.gui.battle.views.minimap
{
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import net.wg.data.constants.generated.BATTLE_MINIMAP_CONSTS;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class ScenarioLayer extends Sprite implements IDisposable
   {
       
      
      private var _w:int;
      
      private var _h:int;
      
      private var _disposed:Boolean = false;
      
      private var _images:Dictionary;
      
      private var _effectLayer:Sprite;
      
      private var _alertLayer:Sprite;
      
      public function ScenarioLayer()
      {
         this._images = new Dictionary();
         this._effectLayer = new Sprite();
         this._alertLayer = new Sprite();
         super();
         addChild(this._effectLayer);
         addChild(this._alertLayer);
      }
      
      public function clearScenarioEvent(param1:String) : void
      {
         if(this._images.hasOwnProperty(param1))
         {
            this.cleanImage(this._images[param1]);
            delete this._images[param1];
         }
      }
      
      public final function dispose() : void
      {
         var _loc1_:UILoaderAlt = null;
         this._disposed = true;
         for each(_loc1_ in this._images)
         {
            this.cleanImage(_loc1_);
         }
         App.utils.data.cleanupDynamicObject(this._images);
         this._images = null;
         this._effectLayer = null;
         this._alertLayer = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function setScenarioEvent(param1:String, param2:String, param3:String) : void
      {
         var _loc4_:UILoaderAlt = null;
         if(this._images.hasOwnProperty(param1))
         {
            _loc4_ = this._images[param1];
         }
         else
         {
            _loc4_ = new UILoaderAlt();
            _loc4_.autoSize = false;
            switch(param3)
            {
               case BATTLE_MINIMAP_CONSTS.SCENARIO_EVENT_ALERT:
                  this._alertLayer.addChild(_loc4_);
                  break;
               case BATTLE_MINIMAP_CONSTS.SCENARIO_EVENT_EFFECT:
               default:
                  this._effectLayer.addChild(_loc4_);
            }
            this._images[param1] = _loc4_;
         }
         _loc4_.addEventListener(UILoaderEvent.COMPLETE,this.onImageCompleteHandler);
         _loc4_.visible = false;
         _loc4_.source = param2;
      }
      
      public function setScenarioEventVisible(param1:String, param2:Boolean) : void
      {
         if(this._images.hasOwnProperty(param1))
         {
            this._images[param1].visible = param2;
         }
      }
      
      public function updateSize(param1:int, param2:int) : void
      {
         var _loc3_:UILoaderAlt = null;
         this._w = param1;
         this._h = param2;
         this.width = this._alertLayer.width = this._effectLayer.width = this._w;
         this.height = this._alertLayer.height = this._effectLayer.height = this._h;
         scaleX = this._alertLayer.scaleX = this._effectLayer.scaleX = 1;
         scaleY = this._alertLayer.scaleY = this._effectLayer.scaleY = 1;
         for each(_loc3_ in this._images)
         {
            _loc3_.width = this._w;
            _loc3_.height = this._h;
         }
      }
      
      private function cleanImage(param1:UILoaderAlt) : void
      {
         param1.removeEventListener(UILoaderEvent.COMPLETE,this.onImageCompleteHandler);
         param1.parent.removeChild(param1);
         param1.dispose();
         param1 = null;
      }
      
      private function onImageCompleteHandler(param1:UILoaderEvent) : void
      {
         var _loc2_:UILoaderAlt = param1.target as UILoaderAlt;
         if(_loc2_)
         {
            _loc2_.removeEventListener(UILoaderEvent.COMPLETE,this.onImageCompleteHandler);
            _loc2_.width = this._w;
            _loc2_.height = this._h;
         }
      }
   }
}
