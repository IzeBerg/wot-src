package net.wg.gui.components.crosshairPanel.components.gunMarker
{
   import flash.display.MovieClip;
   import net.wg.data.constants.generated.GUN_MARKER_VIEW_CONSTANTS;
   import net.wg.gui.components.crosshairPanel.components.gunMarker.constants.GunMarkerConsts;
   import net.wg.gui.components.crosshairPanel.constants.CrosshairConsts;
   import net.wg.infrastructure.base.SimpleContainer;
   
   public class GunMarkerTag extends SimpleContainer
   {
       
      
      public var tag:MovieClip = null;
      
      private var _gunTagType:Number = -1;
      
      private var _colorName:String = "";
      
      private var _reloadingState:String = "";
      
      public function GunMarkerTag()
      {
         super();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         super.draw();
         if(isInvalid(GunMarkerConsts.GUN_TAG_TYPE_VALIDATION))
         {
            gotoAndStop(GunMarkerConsts.GUN_TAG_PREFIX + this._gunTagType);
            invalidate(GunMarkerConsts.GUN_TAG_COLOR_VALIDATION,GunMarkerConsts.GUN_RELOADING_STATE_VALIDATION);
         }
         if(isInvalid(GunMarkerConsts.GUN_TAG_COLOR_VALIDATION))
         {
            if(this._colorName != "" && GUN_MARKER_VIEW_CONSTANTS.GUN_TAG_SHOT_RESULT_TYPES.indexOf(this._gunTagType) != -1)
            {
               this.tag.gotoAndStop(this._colorName);
            }
         }
         if(isInvalid(GunMarkerConsts.GUN_RELOADING_STATE_VALIDATION))
         {
            if(this._reloadingState != "" && GUN_MARKER_VIEW_CONSTANTS.GUN_TAG_RELOADING_TYPES.indexOf(this._gunTagType) != -1)
            {
               _loc1_ = !(this._reloadingState == CrosshairConsts.RELOADING_ENDED || this._reloadingState == CrosshairConsts.RELOADING_END);
               this.tag.gotoAndStop(!!_loc1_ ? GunMarkerConsts.GUN_MARKER_TAG_RELOAD_PROGRESS : GunMarkerConsts.GUN_MARKER_TAG_RELOAD_FINISH);
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.tag = null;
         super.onDispose();
      }
      
      public function setColor(param1:String) : void
      {
         if(this._colorName != param1)
         {
            this._colorName = param1;
            invalidate(GunMarkerConsts.GUN_TAG_COLOR_VALIDATION);
         }
      }
      
      public function setReloadingState(param1:String) : void
      {
         if(this._reloadingState != param1)
         {
            this._reloadingState = param1;
            invalidate(GunMarkerConsts.GUN_RELOADING_STATE_VALIDATION);
         }
      }
      
      public function setType(param1:Number) : void
      {
         if(this._gunTagType != param1)
         {
            this._gunTagType = param1;
            invalidate(GunMarkerConsts.GUN_TAG_TYPE_VALIDATION);
         }
      }
   }
}
