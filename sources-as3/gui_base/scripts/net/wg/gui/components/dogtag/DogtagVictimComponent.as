package net.wg.gui.components.dogtag
{
   import fl.motion.easing.Cubic;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.motion.Tween;
   
   public class DogtagVictimComponent extends UIComponentEx
   {
      
      private static const VICTIM_DOGTAG_LINGERING_TIME:int = 2000;
      
      private static const TWEEN_TIME:int = 250;
      
      private static const TWEEN_X_OFFSET:int = 110;
       
      
      public var dogtagUp:DogtagUpPlateVictim = null;
      
      private var _tweenIn:Tween = null;
      
      private var _tweenOut:Tween = null;
      
      public function DogtagVictimComponent()
      {
         super();
         mouseEnabled = false;
         mouseChildren = false;
      }
      
      override protected function onDispose() : void
      {
         this.dogtagUp.dispose();
         this.dogtagUp = null;
         if(this._tweenIn)
         {
            this._tweenIn.paused = true;
            this._tweenIn.dispose();
            this._tweenIn = null;
         }
         if(this._tweenOut)
         {
            this._tweenOut.paused = true;
            this._tweenOut.dispose();
            this._tweenOut = null;
         }
         super.onDispose();
      }
      
      public function setDogTagInfo(param1:String, param2:String) : void
      {
         this.dogtagUp.setDogTagInfo(RES_ICONS.maps_icons_dogtags_big_backgrounds_all_png(param1),RES_ICONS.maps_icons_dogtags_big_engravings_all_png(param2));
      }
      
      private function onComplete(param1:Tween) : void
      {
         dispatchEvent(new DogTagEvent(DogTagEvent.ON_VICTIM_DOGTAG_FADE_OUT));
      }
      
      public function animate() : void
      {
         this.alpha = 0;
         this.x = App.appWidth / 2;
         if(this._tweenIn)
         {
            this._tweenIn.paused = true;
         }
         if(this._tweenOut)
         {
            this._tweenOut.paused = true;
         }
         this._tweenIn = new Tween(TWEEN_TIME,this,{
            "alpha":1,
            "x":this.x - TWEEN_X_OFFSET
         },{
            "paused":false,
            "ease":Cubic.easeOut
         });
         this._tweenOut = new Tween(TWEEN_TIME,this,{
            "alpha":0,
            "x":this.x + TWEEN_X_OFFSET
         },{
            "delay":VICTIM_DOGTAG_LINGERING_TIME,
            "paused":false,
            "ease":Cubic.easeOut,
            "onComplete":this.onComplete
         });
      }
   }
}
