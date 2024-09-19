package net.wg.gui.battle.views.staticMarkers.targetPoint
{
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.utils.getDefinitionByName;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Values;
   import net.wg.gui.battle.views.actionMarkers.BaseActionMarker;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.motion.Tween;
   import scaleform.gfx.TextFieldEx;
   
   public class TargetPointMarker extends BaseActionMarker implements IDisposable
   {
      
      private static const ALPHA_SPEED:int = 1;
      
      private static const SHAPE_XY:Point = new Point(-60,-86);
      
      private static const REPLY_POSITION:Point = new Point(25,-15);
      
      private static const COLOR_WHITE:String = "white";
      
      private static const COLOR_GREEN:String = "green";
      
      private static const COLOR_YELLOW:String = "yellow";
      
      private static const COLOR_ORANGE:String = "orange";
      
      private static const ANIMATION_MC:String = "AnimationMC";
      
      private static const REPLIED_ME_STATE:int = 1;
      
      private static const HOVER_POS_Y:int = -7;
      
      private static const REPLYME_POS_Y:int = -27;
      
      private static const ANIMATION_POS_Y:int = -25;
       
      
      public var replyMe:MovieClip = null;
      
      public var hover:MovieClip = null;
      
      public var marker:MovieClip = null;
      
      public var clickAnimation:MovieClip = null;
      
      public var distanceFieldWhite:TextField = null;
      
      public var distanceFieldGreen:TextField = null;
      
      public var distanceFieldYellow:TextField = null;
      
      public var distanceFieldOrange:TextField = null;
      
      public var bgShadow:Sprite = null;
      
      private var _metersString:String;
      
      private var _distanceTF:TextField = null;
      
      private var _shapeName:String = "arrow";
      
      private var _replyMeName:String = "targetPointReplyMe";
      
      private var _highlightName:String = "targetPointHighlight";
      
      private var _minDistance:Number = 0;
      
      private var _alphaZone:Number = 0;
      
      private var _distance:Number = 120;
      
      private var _isShow:Boolean = false;
      
      private var _tween:Tween = null;
      
      private var _shapeBitmap:Bitmap = null;
      
      public function TargetPointMarker()
      {
         super();
         this._distanceTF = this.distanceFieldGreen;
         this.distanceFieldWhite.visible = false;
         this.distanceFieldGreen.visible = false;
         this.distanceFieldYellow.visible = false;
         this.distanceFieldOrange.visible = false;
         TextFieldEx.setNoTranslate(this.distanceFieldWhite,true);
         TextFieldEx.setNoTranslate(this.distanceFieldGreen,true);
         TextFieldEx.setNoTranslate(this.distanceFieldYellow,true);
         TextFieldEx.setNoTranslate(this.distanceFieldOrange,true);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.setShape();
         this.setInitialAlpha();
         this.setDistanceText();
         this.setAnimation();
         this.setReplyMe();
         this.setHover();
      }
      
      override protected function onDispose() : void
      {
         if(this._shapeBitmap != null)
         {
            if(this._shapeBitmap.bitmapData != null)
            {
               this._shapeBitmap.bitmapData.dispose();
               this._shapeBitmap.bitmapData = null;
            }
            this._shapeBitmap = null;
         }
         this.hover = null;
         this.replyMe = null;
         this.clickAnimation = null;
         this.marker = null;
         this.distanceFieldWhite = null;
         this.distanceFieldGreen = null;
         this.distanceFieldYellow = null;
         this.distanceFieldOrange = null;
         this.bgShadow = null;
         this.clearTween();
         this._distanceTF = null;
         super.onDispose();
      }
      
      public function doAlphaAnimation() : void
      {
         var _loc1_:int = 0;
         if(this._alphaZone > 0)
         {
            this.clearTween();
            _loc1_ = this._distance - this._minDistance;
            if(this._isShow && _loc1_ <= 0)
            {
               this._tween = new Tween(ALPHA_SPEED,this,{"alpha":0});
               this._isShow = false;
            }
            else if(!this._isShow && _loc1_ >= this._alphaZone)
            {
               this._tween = new Tween(ALPHA_SPEED,this,{"alpha":1});
               this._isShow = true;
            }
         }
      }
      
      public function init(param1:String, param2:String, param3:String, param4:Number, param5:Number, param6:Number, param7:String, param8:String = "green") : void
      {
         this._shapeName = param1;
         this._replyMeName = param2;
         this._highlightName = param3;
         this._minDistance = param4;
         this._alphaZone = param5 - param4;
         this._distance = !isNaN(param6) ? Number(Math.round(param6)) : Number(-1);
         switch(param8)
         {
            case COLOR_WHITE:
               this._distanceTF = this.distanceFieldWhite;
               break;
            case COLOR_GREEN:
               this._distanceTF = this.distanceFieldGreen;
               break;
            case COLOR_YELLOW:
               this._distanceTF = this.distanceFieldYellow;
               break;
            case COLOR_ORANGE:
               this._distanceTF = this.distanceFieldOrange;
               break;
            default:
               this._distanceTF = this.distanceFieldGreen;
         }
         this._metersString = param7;
         this._distanceTF.visible = true;
         if(initialized)
         {
            this.setShape();
            this.setInitialAlpha();
            this.setDistanceText();
            this.setAnimation();
            this.setReplyMe();
            this.setHover();
         }
      }
      
      public function activateHover(param1:Boolean) : void
      {
         if(this.hover)
         {
            this.hover.visible = param1;
         }
      }
      
      public function setActiveState(param1:int) : void
      {
         if(this.replyMe)
         {
            this.replyMe.visible = param1 == REPLIED_ME_STATE;
         }
      }
      
      public function triggerClickAnimation() : void
      {
         if(this.clickAnimation)
         {
            this.clickAnimation.visible = true;
            this.clickAnimation.play();
         }
      }
      
      public function setDistance(param1:Number) : void
      {
         var _loc2_:Number = !isNaN(param1) ? Number(Math.round(param1)) : Number(-1);
         if(this._distance == _loc2_)
         {
            return;
         }
         this._distance = _loc2_;
         this.doAlphaAnimation();
         this.setDistanceText();
      }
      
      override protected function get getReplyPosition() : Point
      {
         return REPLY_POSITION;
      }
      
      private function setInitialAlpha() : void
      {
         if(this._alphaZone > 0)
         {
            if(this._distance - this._minDistance <= 0)
            {
               alpha = 0;
               this._isShow = false;
            }
            else
            {
               alpha = 1;
               this._isShow = true;
            }
         }
      }
      
      private function setDistanceText() : void
      {
         if(this._distance > -1)
         {
            this._distanceTF.text = this._distance.toString() + this._metersString;
         }
         else
         {
            this._distanceTF.text = Values.EMPTY_STR;
         }
      }
      
      protected function setShape() : void
      {
         var shapeBitmapClass:Class = null;
         if(this._shapeBitmap != null)
         {
            this.marker.removeChild(this._shapeBitmap);
            if(this._shapeBitmap.bitmapData != null)
            {
               this._shapeBitmap.bitmapData.dispose();
               this._shapeBitmap.bitmapData = null;
            }
         }
         try
         {
            shapeBitmapClass = getDefinitionByName(this._shapeName) as Class;
            this._shapeBitmap = new Bitmap(new shapeBitmapClass());
            this._shapeBitmap.x = SHAPE_XY.x;
            this._shapeBitmap.y = SHAPE_XY.y;
            this.marker.addChild(this._shapeBitmap);
         }
         catch(error:ReferenceError)
         {
            DebugUtils.LOG_ERROR(Errors.BAD_LINKAGE + _shapeName);
         }
      }
      
      protected function setAnimation() : void
      {
         this.clickAnimation = this.createMovieClip(this._shapeName + ANIMATION_MC,ANIMATION_POS_Y);
      }
      
      private function setReplyMe() : void
      {
         this.replyMe = this.createMovieClip(this._replyMeName,REPLYME_POS_Y);
      }
      
      private function setHover() : void
      {
         this.hover = this.createMovieClip(this._highlightName,HOVER_POS_Y);
      }
      
      private function clearTween() : void
      {
         if(this._tween != null)
         {
            this._tween.paused = true;
            this._tween.dispose();
            this._tween = null;
         }
      }
      
      private function createMovieClip(param1:String, param2:int = 0) : MovieClip
      {
         var mcClass:Class = null;
         var linkage:String = param1;
         var posY:int = param2;
         var mc:MovieClip = null;
         try
         {
            mcClass = getDefinitionByName(linkage) as Class;
            mc = new mcClass();
            if(mc)
            {
               addChild(mc);
               mc.y = posY;
               mc.visible = false;
            }
         }
         catch(error:ReferenceError)
         {
         }
         return mc;
      }
   }
}
