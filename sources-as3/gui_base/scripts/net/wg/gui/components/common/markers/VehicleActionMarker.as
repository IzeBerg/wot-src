package net.wg.gui.components.common.markers
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.motion.Tween;
   
   public class VehicleActionMarker extends UIComponentEx
   {
      
      private static const HIDE_DURATION:Number = 1000;
       
      
      private var _actionRendererMap:Object;
      
      private var currentRenderer:MovieClip;
      
      private var hideTween:Tween;
      
      public function VehicleActionMarker()
      {
         super();
      }
      
      public function showAction(param1:String) : void
      {
         var _loc2_:String = this._actionRendererMap[param1];
         if(_loc2_)
         {
            this.currentRenderer = this.createActionRenderer(_loc2_);
         }
      }
      
      public function stopAction() : void
      {
         if(this.currentRenderer)
         {
            this.hideTween = new Tween(HIDE_DURATION,this.currentRenderer,{"alpha":0});
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
      }
      
      private function removeActionRenderer() : void
      {
         if(!this.currentRenderer)
         {
            return;
         }
         removeChild(this.currentRenderer);
         this.currentRenderer = null;
      }
      
      private function createActionRenderer(param1:String) : MovieClip
      {
         var _loc2_:MovieClip = null;
         this.removeActionRenderer();
         _loc2_ = App.utils.classFactory.getComponent(param1,MovieClip) as MovieClip;
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
      
      override protected function onDispose() : void
      {
         this.removeActionRenderer();
         this._actionRendererMap = null;
         this.hideTween = null;
         super.onDispose();
      }
   }
}
