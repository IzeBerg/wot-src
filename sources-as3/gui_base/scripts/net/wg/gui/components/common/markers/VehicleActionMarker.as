package net.wg.gui.components.common.markers
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.utils.IClassFactory;
   import scaleform.clik.motion.Tween;
   
   public class VehicleActionMarker extends UIComponentEx
   {
      
      private static const HIDE_DURATION:uint = 1000;
       
      
      private var _actionRendererMap:Object;
      
      private var _currentRenderer:MovieClip;
      
      private var _hideTween:Tween;
      
      private var _classFactory:IClassFactory;
      
      public function VehicleActionMarker()
      {
         this._classFactory = App.utils.classFactory;
         super();
      }
      
      override protected function onDispose() : void
      {
         this.removeActionRenderer();
         App.utils.data.cleanupDynamicObject(this._actionRendererMap);
         this._currentRenderer = null;
         this._actionRendererMap = null;
         this._classFactory = null;
         if(this._hideTween)
         {
            this._hideTween.dispose();
            this._hideTween = null;
         }
         super.onDispose();
      }
      
      public function showAction(param1:String) : void
      {
         var _loc2_:String = this._actionRendererMap[param1];
         if(_loc2_)
         {
            this._currentRenderer = this.createActionRenderer(_loc2_);
         }
      }
      
      public function stopAction() : void
      {
         if(this._currentRenderer)
         {
            this._hideTween = new Tween(HIDE_DURATION,this._currentRenderer,{"alpha":0});
         }
      }
      
      private function removeActionRenderer() : void
      {
         if(!this._currentRenderer)
         {
            return;
         }
         removeChild(this._currentRenderer);
         this._currentRenderer = null;
      }
      
      private function createActionRenderer(param1:String) : MovieClip
      {
         this.removeActionRenderer();
         var _loc2_:MovieClip = this._classFactory.getComponent(param1,MovieClip) as MovieClip;
         if(_loc2_)
         {
            addChild(_loc2_);
         }
         return _loc2_;
      }
      
      [Inspectable(defaultValue="attack:,attackSPG:,reloading_gun:,reloading_gunSPG:,help_me:,help_meSPG:,follow_me:,follow_meSPG:,attackSender:,attackSenderSPG:,negative:,negativeSPG:,positive:,positiveSPG:,stop:,stopSPG:,help_me_ex:,help_me_exSPG:,turn_back:,turn_backSPG:",name="actionRenderers",type="Object")]
      public function get actionRenderers() : Object
      {
         return this._actionRendererMap;
      }
      
      public function set actionRenderers(param1:Object) : void
      {
         this._actionRendererMap = param1;
      }
   }
}
