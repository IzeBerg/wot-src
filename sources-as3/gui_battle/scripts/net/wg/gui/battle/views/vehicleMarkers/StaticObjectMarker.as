package net.wg.gui.battle.views.vehicleMarkers
{
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.utils.getDefinitionByName;
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.components.BattleUIComponent;
   import scaleform.clik.motion.Tween;
   import scaleform.gfx.TextFieldEx;
   
   public class StaticObjectMarker extends BattleUIComponent
   {
      
      private static const ALPHA_SPEED:int = 1;
      
      private static const SHAPE_XY:Point = new Point(-145,-178);
      
      private static const COLOR_GREEN:String = "green";
      
      private static const COLOR_YELLOW:String = "yellow";
      
      private static const COLOR_ORANGE:String = "orange";
       
      
      public var marker:MovieClip = null;
      
      public var distanceFieldGreen:TextField = null;
      
      public var distanceFieldYellow:TextField = null;
      
      public var distanceFieldOrange:TextField = null;
      
      public var bgShadow:Sprite = null;
      
      private var _metersString:String;
      
      private var _distanceTF:TextField = null;
      
      private var _shapeName:String = "arrow";
      
      private var _minDistance:Number = 0;
      
      private var _alphaZone:Number = 0;
      
      private var _distance:Number = 120;
      
      private var _isShow:Boolean = false;
      
      private var _tween:Tween = null;
      
      private var _shapeBitmap:Bitmap = null;
      
      public function StaticObjectMarker()
      {
         super();
         this._distanceTF = this.distanceFieldGreen;
         this.distanceFieldGreen.visible = false;
         this.distanceFieldYellow.visible = false;
         this.distanceFieldOrange.visible = false;
         TextFieldEx.setNoTranslate(this.distanceFieldGreen,true);
         TextFieldEx.setNoTranslate(this.distanceFieldYellow,true);
         TextFieldEx.setNoTranslate(this.distanceFieldOrange,true);
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
         this.marker = null;
         this.distanceFieldGreen = null;
         this.distanceFieldYellow = null;
         this.distanceFieldOrange = null;
         this.bgShadow = null;
         this.clearTween();
         this._distanceTF = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.setShape();
         this.setInitialAlpha();
         this.setDistanceText();
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
      
      public function init(param1:String, param2:Number, param3:Number, param4:Number, param5:String, param6:String = "green") : void
      {
         this._shapeName = param1;
         this._minDistance = param2;
         this._alphaZone = param3 - param2;
         this._distance = !isNaN(param4) ? Number(Math.round(param4)) : Number(-1);
         switch(param6)
         {
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
         this._metersString = param5;
         this._distanceTF.visible = true;
         if(initialized)
         {
            this.setShape();
            this.setInitialAlpha();
            this.setDistanceText();
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
            this._distanceTF.text = "";
         }
      }
      
      private function setShape() : void
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
      
      private function clearTween() : void
      {
         if(this._tween != null)
         {
            this._tween.paused = true;
            this._tween.dispose();
            this._tween = null;
         }
      }
   }
}
