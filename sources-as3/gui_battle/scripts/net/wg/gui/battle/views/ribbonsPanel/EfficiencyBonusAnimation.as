package net.wg.gui.battle.views.ribbonsPanel
{
   import fl.motion.easing.Linear;
   import flash.display.MovieClip;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.motion.Tween;
   
   public class EfficiencyBonusAnimation extends MovieClip
   {
      
      private static const VALUE_OFFSET_X:int = 8;
      
      private static const ROLE_IMAGE_FX_SCALE:Number = 1.5;
      
      private static const ROLE_IMAGE_FX_DELAY:int = 400;
      
      private static const ROLE_IMAGE_FX_DURATION:int = 300;
       
      
      public var roleImage:BattleAtlasSprite = null;
      
      public var roleImageFx:BattleAtlasSprite = null;
      
      private var _isExtendedAnim:Boolean = true;
      
      private var _roleImageFxTween:Tween = null;
      
      public function EfficiencyBonusAnimation()
      {
         super();
         visible = false;
         x = VALUE_OFFSET_X;
         this.roleImage.isSmoothingEnabled = true;
         this.roleImageFx.isSmoothingEnabled = true;
         this.roleImage.visible = false;
         this.roleImageFx.visible = false;
         this.roleImageFx.isCentralize = true;
      }
      
      public final function dispose() : void
      {
         this.roleImage = null;
         this.roleImageFx = null;
         if(this._roleImageFxTween)
         {
            this._roleImageFxTween.dispose();
            this._roleImageFxTween = null;
         }
      }
      
      public function setSettings(param1:Boolean) : void
      {
         this._isExtendedAnim = param1;
         if(this._isExtendedAnim)
         {
            this._roleImageFxTween = new Tween(ROLE_IMAGE_FX_DURATION,this.roleImageFx,{
               "scaleX":1,
               "scaleY":1
            },{
               "paused":true,
               "ease":Linear.easeOut,
               "delay":ROLE_IMAGE_FX_DELAY,
               "onComplete":this.onTweenComplete
            });
         }
      }
      
      public function show() : void
      {
         if(this._isExtendedAnim && visible)
         {
            this.roleImage.visible = false;
            this.roleImageFx.scaleX = this.roleImageFx.scaleY = ROLE_IMAGE_FX_SCALE;
            this.roleImageFx.visible = true;
            this._roleImageFxTween.paused = false;
         }
      }
      
      public function update(param1:String, param2:String) : void
      {
         visible = StringUtils.isNotEmpty(param1);
         if(visible)
         {
            this.roleImage.visible = !this._isExtendedAnim;
            this.roleImage.imageName = BATTLEATLAS.getRole32x32Icon(param2);
            if(this._isExtendedAnim)
            {
               this.roleImageFx.imageName = BATTLEATLAS.getRole32x32Icon(param2);
            }
         }
      }
      
      private function onTweenComplete() : void
      {
         this.roleImage.visible = true;
         this.roleImageFx.visible = false;
      }
   }
}
