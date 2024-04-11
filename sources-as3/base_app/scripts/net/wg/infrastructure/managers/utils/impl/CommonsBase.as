package net.wg.infrastructure.managers.utils.impl
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.InteractiveObject;
   import flash.display.PixelSnapping;
   import flash.display.Sprite;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.BlurFilter;
   import flash.filters.ColorMatrixFilter;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextLineMetrics;
   import flash.ui.Keyboard;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.KeyProps;
   import net.wg.data.constants.KeysMap;
   import net.wg.data.constants.Values;
   import net.wg.infrastructure.exceptions.AbstractException;
   import net.wg.infrastructure.interfaces.IUserProps;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.utils.ICommons;
   import net.wg.utils.TextFieldUtils;
   import scaleform.clik.core.UIComponent;
   import scaleform.gfx.MouseEventEx;
   
   public class CommonsBase implements ICommons
   {
      
      private static var _s_found:Array = [];
      
      protected static const TEAM_KILLER_COLOR:Number = 647935;
      
      protected static const TEAM_KILLER_FORMAT:TextFormat = new TextFormat(null,null,TEAM_KILLER_COLOR);
      
      protected static const IMG_TAG_CLOSE:String = "\"/>";
      
      protected static const IMG_TAG_OPEN_BASIC:String = "<IMG SRC=\"img://gui/maps/icons/library/basic_small.png\" width=\"26\" height=\"16\" vspace=\"";
      
      protected static const IMG_TAG_EYE_ICON:String = "<IMG SRC=\"img://gui/maps/icons/library/icon_eye.png\" width=\"16\" height=\"13\" vspace=\"0\"/>";
      
      protected static const IMG_TAG_OPEN_PREMIUM:String = "<IMG SRC=\"img://gui/maps/icons/library/premium_small.png\" width=\"34\" height=\"16\" vspace=\"";
      
      protected static const REFERRAL_IMG_TAG:String = "<IMG SRC=\"img://gui/maps/icons/referral/referralSmallHand.png\" width=\"16\" height=\"16\" vspace=\"-4\"/>";
      
      protected static const CLAN_TAG_OPEN:String = "[";
      
      protected static const CLAN_TAG_CLOSE:String = "]";
      
      protected static const CUT_SYMBOLS_STR:String = "..";
      
      protected static const TEXT_FIELD_BOUNDS_WIDTH:uint = 4;
      
      private static const TEXTFIELD_PADDING:Number = 5;
      
      private static const STR_TWO_DOTS:String = "..";
      
      private static const FIELD_COMMAND:String = "command";
      
      private static const FIELD_TO_SHOW:String = "to_show";
      
      private static const EMPTY_HIT_AREA_NAME:String = "emptyHitArea";
       
      
      private var _textFieldUtils:TextFieldUtils = null;
      
      public function CommonsBase()
      {
         super();
         this._textFieldUtils = TextFieldUtils.instance;
      }
      
      private static function isKeyboardKey(param1:Number) : Boolean
      {
         var _loc2_:int = 7;
         return param1 > _loc2_;
      }
      
      private static function isNumberKey(param1:Number) : Boolean
      {
         return param1 >= Keyboard.NUMBER_0 && param1 <= Keyboard.NUMBER_9;
      }
      
      public function addBlankLines(param1:String, param2:TextField, param3:Vector.<TextField>) : void
      {
         var _loc6_:TextField = null;
         var _loc7_:int = 0;
         var _loc4_:String = param2.htmlText;
         param2.htmlText = param1;
         var _loc5_:int = Math.round(param2.textHeight / param2.getLineMetrics(0).height);
         for each(_loc6_ in param3)
         {
            _loc7_ = 1;
            while(_loc7_ < _loc5_)
            {
               _loc6_.htmlText += Values.NEW_LINE;
               _loc7_++;
            }
         }
         param2.htmlText = _loc4_;
      }
      
      public function addMultipleHandlers(param1:Vector.<IEventDispatcher>, param2:String, param3:Function) : void
      {
         var _loc4_:IEventDispatcher = null;
         for each(_loc4_ in param1)
         {
            _loc4_.addEventListener(param2,param3);
         }
      }
      
      public function cutBitmapFromBitmapData(param1:BitmapData, param2:Rectangle) : Bitmap
      {
         var _loc3_:BitmapData = new BitmapData(param2.width,param2.height,true,13421772);
         _loc3_.copyPixels(param1,new Rectangle(param2.x,param2.y,param2.width,param2.height),new Point(0,0));
         return new Bitmap(_loc3_,PixelSnapping.AUTO,true);
      }
      
      public function cutHtmlText(param1:String) : String
      {
         return this._textFieldUtils.cutHtmlText(param1);
      }
      
      public function flipHorizontal(param1:DisplayObject) : void
      {
         var _loc2_:Matrix = param1.transform.matrix;
         _loc2_.a = -1;
         _loc2_.tx = param1.width + param1.x;
         param1.transform.matrix = _loc2_;
      }
      
      public function formatPlayerName(param1:TextField, param2:IUserProps, param3:Boolean = false, param4:Boolean = false, param5:String = "..") : Boolean
      {
         throw new AbstractException(Errors.ABSTRACT_INVOKE);
      }
      
      public function getFullPlayerName(param1:IUserProps, param2:Boolean = false) : String
      {
         throw new AbstractException(Errors.ABSTRACT_INVOKE);
      }
      
      public function getUserProps(param1:String, param2:String = null, param3:String = null, param4:int = 0, param5:Array = null, param6:String = "") : IUserProps
      {
         return new UserProps(param1,param2,param3,param4,param5,param6);
      }
      
      public function initTabIndex(param1:Vector.<InteractiveObject>) : void
      {
         var _loc2_:int = param1.length;
         var _loc3_:Number = 0;
         while(_loc3_ < _loc2_)
         {
            InteractiveObject(param1[_loc3_]).tabIndex = _loc3_ + 1;
            _loc3_++;
         }
      }
      
      public function keyToString(param1:Number) : KeyProps
      {
         var _loc2_:Number = this.getVirtualKey(param1);
         var _loc3_:KeyProps = new KeyProps();
         var _loc4_:Number = !!isNumberKey(_loc2_) ? Number(_loc2_) : Number(this.getCharFromKey(_loc2_));
         var _loc5_:String = String.fromCharCode(Boolean(_loc4_) ? _loc4_ : _loc2_);
         var _loc6_:String = String.fromCharCode(param1);
         if(KeysMap.mapping.hasOwnProperty(_loc2_.toString()))
         {
            if(KeysMap.mapping[_loc2_].hasOwnProperty(FIELD_TO_SHOW))
            {
               _loc3_.keyName = App.utils.locale.makeString(KeysMap.mapping[_loc2_].to_show);
            }
            else
            {
               _loc3_.keyName = App.utils.toUpperOrLowerCase(_loc5_,true);
            }
         }
         else
         {
            _loc3_.keyName = App.utils.toUpperOrLowerCase(_loc5_,true);
         }
         if(KeysMap.mapping.hasOwnProperty(param1.toString()))
         {
            if(KeysMap.mapping[param1].hasOwnProperty(FIELD_COMMAND))
            {
               _loc3_.keyCommand = KeysMap.mapping[param1].command;
            }
            else
            {
               _loc3_.keyCommand = App.utils.toUpperOrLowerCase(_loc6_,true);
            }
         }
         else
         {
            _loc3_.keyCommand = App.utils.toUpperOrLowerCase(_loc6_,true);
         }
         return _loc3_;
      }
      
      public function moveDsiplObjToEndOfText(param1:DisplayObject, param2:TextField, param3:int = 0, param4:int = 0) : void
      {
         var _loc11_:TextLineMetrics = null;
         var _loc5_:int = 2;
         var _loc6_:int = param2.numLines;
         var _loc7_:int = -1;
         var _loc8_:int = _loc6_ - 1;
         while(_loc8_ >= 0)
         {
            if(param2.getLineText(_loc8_))
            {
               _loc7_ = _loc8_;
               break;
            }
            _loc8_--;
         }
         var _loc9_:int = Math.round(param2.x + param3);
         var _loc10_:int = Math.round(param2.y + param4);
         if(_loc7_ > -1)
         {
            _loc11_ = param2.getLineMetrics(_loc7_);
            _loc9_ = Math.round(param2.x + _loc11_.x + _loc11_.width + param3);
            _loc10_ = Math.round(param2.y + param2.textHeight + _loc5_ - (_loc11_.height - _loc11_.leading + param1.height >> 1) + param4);
         }
         param1.x = _loc9_;
         param1.y = _loc10_;
      }
      
      public function releaseReferences(param1:Object, param2:Boolean = true) : void
      {
         var _loc4_:IDisposable = null;
         var _loc5_:* = null;
         var _loc6_:DisplayObjectContainer = null;
         var _loc7_:Object = null;
         var _loc8_:DisplayObject = null;
         if(param1 == null || param1 == App.stage || _s_found.indexOf(param1) != -1)
         {
            return;
         }
         if(!param2)
         {
            _loc4_ = param1 as IDisposable;
            if(_loc4_ && !_loc4_.isDisposed())
            {
               _loc4_.dispose();
            }
         }
         _s_found.push(param1);
         var _loc3_:UIComponent = param1 as UIComponent;
         if(!_loc3_ || !_loc3_._deferredDispose)
         {
            for(_loc5_ in param1)
            {
               _loc7_ = param1[_loc5_];
               if(_loc7_ is IDisposable || _loc7_ is DisplayObject)
               {
                  this.releaseReferences(_loc7_,false);
               }
               delete param1[_loc5_];
            }
            _loc6_ = param1 as DisplayObjectContainer;
            if(_loc6_)
            {
               while(_loc6_.numChildren > 0)
               {
                  _loc8_ = _loc6_.getChildAt(0);
                  this.releaseReferences(_loc8_,false);
                  _loc6_.removeChild(_loc8_);
               }
            }
         }
         if(param2)
         {
            if(_s_found.length > 1)
            {
               DebugUtils.LOG_DEBUG("try to release: " + param1 + " has been released. Collected: " + _s_found.length + " objects.");
            }
            _s_found.splice(0);
         }
      }
      
      public function removeMultipleHandlers(param1:Vector.<IEventDispatcher>, param2:String, param3:Function) : void
      {
         var _loc4_:IEventDispatcher = null;
         for each(_loc4_ in param1)
         {
            _loc4_.removeEventListener(param2,param3);
         }
      }
      
      public function rgbToArgb(param1:uint, param2:Number) : uint
      {
         var _loc3_:uint = param1;
         param2 *= 100;
         return uint(_loc3_ + (param2 << 24));
      }
      
      public function setBlur(param1:DisplayObject, param2:Number = 4.0, param3:Number = 4.0, param4:int = 1) : void
      {
         var _loc5_:Array = param1.filters;
         var _loc6_:BlurFilter = new BlurFilter(param2,param3,param4);
         _loc5_.push(_loc6_);
         param1.filters = _loc5_;
      }
      
      public function setColorTransformMultipliers(param1:DisplayObject, param2:Number = 1, param3:Number = 1, param4:Number = 1, param5:Number = 1) : void
      {
         var _loc6_:ColorTransform = param1.transform.colorTransform;
         _loc6_.alphaMultiplier = param2;
         _loc6_.redMultiplier = param3;
         _loc6_.greenMultiplier = param4;
         _loc6_.blueMultiplier = param5;
         param1.transform.colorTransform = _loc6_;
      }
      
      public function setGlowFilter(param1:DisplayObject, param2:Number) : void
      {
         var _loc3_:Array = [];
         var _loc4_:Number = 1;
         var _loc5_:Number = 10;
         var _loc6_:Number = 10;
         var _loc7_:Number = 1.5;
         var _loc8_:Number = 3;
         var _loc9_:Boolean = false;
         var _loc10_:Boolean = false;
         var _loc11_:GlowFilter = new GlowFilter(param2,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_,_loc10_);
         _loc3_.push(_loc11_);
         param1.filters = _loc3_;
      }
      
      public function setSaturation(param1:Sprite, param2:Number) : void
      {
         var object:Sprite = param1;
         var amount:Number = param2;
         var interpolateArrays:Function = function(param1:Array, param2:Array, param3:Number):Object
         {
            var _loc4_:Array = param1.length >= param2.length ? param1.slice() : param2.slice();
            var _loc5_:uint = _loc4_.length;
            while(_loc5_--)
            {
               _loc4_[_loc5_] = param1[_loc5_] + (param2[_loc5_] - param1[_loc5_]) * param3;
            }
            return _loc4_;
         };
         amount /= 100;
         var colorFilter:ColorMatrixFilter = new ColorMatrixFilter();
         var redIdentity:Array = [1,0,0,0,0];
         var greenIdentity:Array = [0,1,0,0,0];
         var blueIdentity:Array = [0,0,1,0,0];
         var alphaIdentity:Array = [0,0,0,1,0];
         var grayluma:Array = [0.3,0.59,0.11,0,0];
         var colmatrix:Array = [];
         colmatrix = colmatrix.concat(interpolateArrays(grayluma,redIdentity,amount));
         colmatrix = colmatrix.concat(interpolateArrays(grayluma,greenIdentity,amount));
         colmatrix = colmatrix.concat(interpolateArrays(grayluma,blueIdentity,amount));
         colmatrix = colmatrix.concat(alphaIdentity);
         colorFilter.matrix = colmatrix;
         object.filters = [colorFilter];
      }
      
      public function setShadowFilter(param1:DisplayObject, param2:uint) : void
      {
         var _loc3_:Number = 7;
         var _loc4_:Number = 90;
         var _loc5_:Number = 1;
         var _loc6_:Number = 10;
         var _loc7_:Number = 10;
         var _loc8_:Number = 0.75;
         var _loc9_:int = BitmapFilterQuality.HIGH;
         this.setShadowFilterWithParams(param1,_loc3_,_loc4_,param2,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_);
      }
      
      public function setShadowFilterWithParams(param1:DisplayObject, param2:Number = 4.0, param3:Number = 45, param4:uint = 0, param5:Number = 1.0, param6:Number = 4.0, param7:Number = 4.0, param8:Number = 1.0, param9:int = 1, param10:Boolean = false, param11:Boolean = false, param12:Boolean = false) : void
      {
         var _loc13_:Array = [];
         var _loc14_:DropShadowFilter = new DropShadowFilter(param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12);
         _loc13_.push(_loc14_);
         param1.filters = _loc13_;
      }
      
      public function truncateHtmlTextMultiline(param1:TextField, param2:String, param3:uint = 1, param4:String = "..") : Boolean
      {
         return this._textFieldUtils.truncateHtmlTextMultiline(param1,param2,param3,param4);
      }
      
      public function truncateTextFieldMultiline(param1:TextField, param2:String, param3:uint, param4:String = "..") : Boolean
      {
         return this._textFieldUtils.truncateTextFieldMultiline(param1,param2,param3,param4);
      }
      
      public function truncateTextFieldText(param1:TextField, param2:String, param3:Boolean = true, param4:Boolean = false, param5:String = "..", param6:uint = 4) : String
      {
         return this._textFieldUtils.truncateTextFieldText(param1,param2,param3,param4,param5,param6);
      }
      
      public function updateChildrenMouseBehavior(param1:DisplayObjectContainer, param2:Boolean, param3:Boolean, param4:Vector.<DisplayObject> = null) : void
      {
         var _loc5_:DisplayObject = null;
         var _loc6_:InteractiveObject = null;
         var _loc7_:DisplayObjectContainer = null;
         var _loc8_:int = param1.numChildren;
         var _loc9_:int = 0;
         while(_loc9_ < _loc8_)
         {
            _loc5_ = param1.getChildAt(_loc9_);
            if(!(param4 != null && param4.indexOf(_loc5_) != -1))
            {
               _loc7_ = _loc5_ as DisplayObjectContainer;
               if(_loc7_ != null)
               {
                  _loc7_.mouseEnabled = param2;
                  _loc7_.mouseChildren = param3;
               }
               else
               {
                  _loc6_ = _loc5_ as InteractiveObject;
                  if(_loc6_ != null)
                  {
                     _loc6_.mouseEnabled = param2;
                  }
               }
            }
            _loc9_++;
         }
      }
      
      public function updateChildrenMouseEnabled(param1:DisplayObjectContainer, param2:Boolean) : void
      {
         var _loc3_:InteractiveObject = null;
         var _loc4_:int = param1.numChildren;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = param1.getChildAt(_loc5_) as InteractiveObject;
            if(_loc3_ != null)
            {
               _loc3_.mouseEnabled = param2;
            }
            _loc5_++;
         }
      }
      
      public function updateTextFieldSize(param1:TextField, param2:Boolean = true, param3:Boolean = true) : void
      {
         if(param3)
         {
            param1.height = param1.textHeight + TEXTFIELD_PADDING | 0;
         }
         if(param2)
         {
            param1.width = param1.textWidth + TEXTFIELD_PADDING | 0;
         }
      }
      
      protected function applyTextProps(param1:TextField, param2:String, param3:TextFormat, param4:Object, param5:String, param6:String) : void
      {
         param1.htmlText = param2;
         param3.size = param4;
         param3.font = param5;
         param3.align = param6;
         param1.setTextFormat(param3);
      }
      
      private function getVirtualKey(param1:Number) : Number
      {
         var _loc2_:Number = NaN;
         if(param1 != KeyProps.KEY_NONE && isKeyboardKey(param1))
         {
            _loc2_ = App.utils.mapScaleformToVirtualKeyS(param1);
            if(_loc2_ != 0)
            {
               param1 = _loc2_;
            }
         }
         return param1;
      }
      
      private function getCharFromKey(param1:Number) : Number
      {
         var _loc2_:Number = App.utils.getCharFromVirtualKeyS(param1);
         if(_loc2_ != 0)
         {
            return _loc2_;
         }
         return param1;
      }
      
      public function isLeftButton(param1:MouseEvent) : Boolean
      {
         if(param1 is MouseEventEx)
         {
            return MouseEventEx(param1).buttonIdx == MouseEventEx.LEFT_BUTTON;
         }
         return true;
      }
      
      public function isRightButton(param1:MouseEvent) : Boolean
      {
         if(param1 is MouseEventEx)
         {
            return MouseEventEx(param1).buttonIdx == MouseEventEx.RIGHT_BUTTON;
         }
         return false;
      }
      
      public function addEmptyHitArea(param1:Sprite) : void
      {
         var _loc2_:Sprite = new Sprite();
         _loc2_.name = EMPTY_HIT_AREA_NAME;
         param1.parent.addChild(_loc2_);
         param1.hitArea = _loc2_;
      }
      
      public function formatNumberToStringWithSpaces(param1:int) : String
      {
         return param1.toString().replace(/\B(?=(\d{3})+(?!\d))/g," ");
      }
   }
}

import net.wg.infrastructure.interfaces.IUserProps;

class UserProps implements IUserProps
{
    
   
   private var _fakeName:String;
   
   private var _userName:String;
   
   private var _clanAbbrev:String;
   
   private var _region:String;
   
   private var _igrType:int = 0;
   
   private var _prefix:String = "";
   
   private var _suffix:String = "";
   
   private var _igrVspace:int = -4;
   
   private var _rgb:Number = NaN;
   
   private var _tags:Array;
   
   private var _isTeamKiller:Boolean = false;
   
   function UserProps(param1:String, param2:String, param3:String, param4:int, param5:Array = null, param6:String = "")
   {
      this._tags = [];
      super();
      this._fakeName = param6;
      this._userName = param1;
      this._clanAbbrev = param2;
      this._region = param3;
      this._igrType = param4;
      this._tags = param5;
   }
   
   public function get fakeName() : String
   {
      return this._fakeName;
   }
   
   public function set fakeName(param1:String) : void
   {
      this._fakeName = param1;
   }
   
   public function get userName() : String
   {
      return this._userName;
   }
   
   public function set userName(param1:String) : void
   {
      this._userName = param1;
   }
   
   public function get clanAbbrev() : String
   {
      return this._clanAbbrev;
   }
   
   public function set clanAbbrev(param1:String) : void
   {
      this._clanAbbrev = param1;
   }
   
   public function get region() : String
   {
      return this._region;
   }
   
   public function set region(param1:String) : void
   {
      this._region = param1;
   }
   
   public function get igrType() : int
   {
      return this._igrType;
   }
   
   public function set igrType(param1:int) : void
   {
      this._igrType = param1;
   }
   
   public function get prefix() : String
   {
      return this._prefix;
   }
   
   public function set prefix(param1:String) : void
   {
      this._prefix = param1;
   }
   
   public function get suffix() : String
   {
      return this._suffix;
   }
   
   public function set suffix(param1:String) : void
   {
      this._suffix = param1;
   }
   
   public function get igrVspace() : int
   {
      return this._igrVspace;
   }
   
   public function set igrVspace(param1:int) : void
   {
      this._igrVspace = param1;
   }
   
   public function get rgb() : Number
   {
      return this._rgb;
   }
   
   public function set rgb(param1:Number) : void
   {
      this._rgb = param1;
   }
   
   public function get tags() : Array
   {
      return Boolean(this._tags) ? this._tags : [];
   }
   
   public function set tags(param1:Array) : void
   {
      this._tags = param1;
   }
   
   public function get isTeamKiller() : Boolean
   {
      return this._isTeamKiller;
   }
   
   public function set isTeamKiller(param1:Boolean) : void
   {
      this._isTeamKiller = param1;
   }
   
   public function get isAnonymized() : Boolean
   {
      return this._fakeName && this._fakeName != this._userName;
   }
}
