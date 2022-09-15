package net.wg.gui.components.advanced
{
   import flash.display.MovieClip;
   import flash.filters.BitmapFilter;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import net.wg.data.constants.ImageCacheTypes;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class TankIcon extends UIComponentEx
   {
      
      private static const ACTION_STATE:String = "action";
      
      private static const STANDART_STATE:String = "standart";
      
      private static const DISTANCE:Number = 0;
      
      private static const ANGEL_IN_DEGREES:Number = 90;
      
      private static const COLOR:Number = 16723968;
      
      private static const TEXT_COLOR:Number = 16754521;
      
      private static const PREMIUM_TEXT_COLOR:Number = 13224374;
      
      private static const ALPHA:Number = 0.7;
      
      private static const PREMIUM_ALPHA:Number = 0.2;
      
      private static const BLUR_X:Number = 12;
      
      private static const PREMIUM_BLUR_X:Number = 8;
      
      private static const BLUR_Y:Number = 12;
      
      private static const PREMIUM_BLUR_Y:Number = 8;
      
      private static const STRENGHT:Number = 3;
      
      private static const PREMIUM_STRENGHT:Number = 4;
      
      private static const QULITY:Number = 2;
      
      private static const INNER:Boolean = false;
      
      private static const KNOCKOUT:Boolean = false;
      
      private static const HIDE_OBJECT:Boolean = false;
      
      private static const EMPTY_STR:String = "";
      
      private static const TANK_TYPE_POSTFIX_ELITE:String = "_elite";
      
      private static const DEF_TANK_LEVEL_ELITE_LEFT:int = 21;
      
      private static const DEF_TANK_LEVEL_PADDING_LEFT:int = 3;
      
      private static const DEF_MULTI_XP_VALUE:int = 2;
       
      
      public var flag:UILoaderAlt;
      
      public var icon:Image;
      
      public var tankTypeMc:MovieClip;
      
      public var levelMc:MovieClip;
      
      public var multyXp:MovieClip;
      
      public var xp:MovieClip;
      
      public var tankNameField:TextField;
      
      public var rentInfoField:TextField;
      
      public var tankNameBg:MovieClip;
      
      public var favoriteMc:MovieClip;
      
      private var _favorite:Boolean = false;
      
      private var _favoriteDirty:Boolean = true;
      
      private var _showMultyXp:Boolean = false;
      
      private var _showMultyXpDirty:Boolean = true;
      
      private var _showXp:Boolean = false;
      
      private var _showXpDirty:Boolean = true;
      
      private var _showName:Boolean = false;
      
      private var _showNameDirty:Boolean = true;
      
      private var _nation:Number;
      
      private var _nationDirty:Boolean = true;
      
      private var _nationName:String;
      
      private var _nationNameDirty:Boolean = true;
      
      private var _image:String;
      
      private var _imageDirty:Boolean = true;
      
      private var _tankType:String;
      
      private var _tankTypeDirty:Boolean = true;
      
      private var _level:Number;
      
      private var _levelDirty:Boolean = true;
      
      private var _multyXpVal:Number;
      
      private var _multyXpValDirty:Boolean = true;
      
      private var _xpVal:Number = 0;
      
      private var _xpValDirty:Boolean = true;
      
      private var _tankName:String;
      
      private var _rentInfo:String;
      
      private var _isRentDirty:Boolean = true;
      
      private var _tankNameDirty:Boolean = true;
      
      private var _isElite:Boolean;
      
      private var _isEliteDirty:Boolean = true;
      
      private var _isPremium:Boolean;
      
      private var _isPremiumDirty:Boolean = true;
      
      private var _isForCompare:Boolean = false;
      
      public function TankIcon()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.flag.dispose();
         this.flag = null;
         this.icon.dispose();
         this.icon = null;
         this.tankTypeMc = null;
         this.levelMc = null;
         this.multyXp = null;
         this.xp = null;
         this.tankNameField.filters.splice(0,this.tankNameField.filters.length);
         this.tankNameField.filters = null;
         this.tankNameField = null;
         this.tankNameBg = null;
         this.favoriteMc = null;
         this.rentInfoField = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.flag.visible = true;
         this.icon.cacheType = ImageCacheTypes.NOT_USE_CACHE;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if((this._multyXpValDirty || this._showMultyXpDirty) && this.multyXp != null)
         {
            this.updateMultyXp();
            this._multyXpValDirty = this._showMultyXpDirty = false;
         }
         if((this._xpValDirty || this._showXpDirty) && this.xp != null)
         {
            this.xp.visible = this.showXp;
            if(this.showXp)
            {
               this.xp.textField.text = String(this.xpVal);
            }
            this._xpValDirty = this._showXpDirty = false;
         }
         if(this._isRentDirty && this.rentInfoField)
         {
            this.rentInfoField.htmlText = this.rentInfo;
            this._isRentDirty = false;
         }
         if((this._tankNameDirty || this._showNameDirty || this._isPremiumDirty) && this.tankNameField && this.tankNameBg)
         {
            this.tankNameField.visible = this.showName;
            this.tankNameBg.visible = this.showName && !this._isForCompare;
            if(this.showName)
            {
               this.tankNameField.htmlText = this.tankName;
            }
            this.updateTankName();
            this._isPremiumDirty = this._tankNameDirty = this._showNameDirty = false;
         }
         if(this._nationDirty && this.flag && this.nation >= 0)
         {
            this.flag.source = RES_ICONS.getNationFlag160x100(App.utils.nations.getNationName(this.nation));
            this._nationDirty = false;
         }
         if(this._nationNameDirty && this.flag && this.nationName)
         {
            this.flag.source = RES_ICONS.getNationFlag160x100(this.nationName);
            this._nationNameDirty = false;
         }
         if(this._imageDirty && this.icon)
         {
            this.icon.visible = true;
            this.icon.source = this._image;
            this._imageDirty = false;
         }
         if((this._isEliteDirty || this._tankTypeDirty) && this.tankTypeMc != null)
         {
            this.updateTankType();
            this._isEliteDirty = this._tankTypeDirty = false;
         }
         if(this._levelDirty && this.levelMc != null && this._level)
         {
            this.levelMc.gotoAndStop(this._level);
            this._levelDirty = false;
         }
         if(this._favoriteDirty && this.favoriteMc != null)
         {
            this.favoriteMc.visible = this.favorite;
            this._favoriteDirty = false;
         }
      }
      
      private function updateTankType() : void
      {
         if(this.tankType)
         {
            this.tankTypeMc.gotoAndStop(this.tankType + (!!this.isElite ? TANK_TYPE_POSTFIX_ELITE : EMPTY_STR));
         }
         if(this.isElite || this._isForCompare)
         {
            this.levelMc.x = DEF_TANK_LEVEL_ELITE_LEFT;
         }
         else
         {
            this.levelMc.x = this.tankTypeMc.x + this.tankTypeMc.width + DEF_TANK_LEVEL_PADDING_LEFT >> 0;
         }
      }
      
      private function updateMultyXp() : void
      {
         if(this.showMultyXp)
         {
            this.multyXp.visible = this.multyXpVal >= DEF_MULTI_XP_VALUE;
            if(this.multyXp.visible && this.multyXpVal > DEF_MULTI_XP_VALUE)
            {
               this.multyXp.gotoAndStop(ACTION_STATE);
               this.multyXp.textField.text = this.multyXpVal;
               this.multyXp.textField.visible = true;
            }
            else if(this.multyXp.visible)
            {
               this.multyXp.gotoAndStop(STANDART_STATE);
               this.multyXp.textField.text = EMPTY_STR;
               this.multyXp.textField.visible = false;
            }
         }
         else
         {
            this.multyXp.visible = false;
         }
      }
      
      private function updateTankName() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:BitmapFilter = null;
         if(this.showName)
         {
            _loc1_ = TEXT_COLOR;
            if(this.isPremium)
            {
               _loc2_ = new DropShadowFilter();
               DropShadowFilter(_loc2_).distance = DISTANCE;
               DropShadowFilter(_loc2_).color = COLOR;
               DropShadowFilter(_loc2_).angle = ANGEL_IN_DEGREES;
               DropShadowFilter(_loc2_).blurX = BLUR_X;
               DropShadowFilter(_loc2_).blurY = BLUR_Y;
               DropShadowFilter(_loc2_).alpha = ALPHA;
               DropShadowFilter(_loc2_).strength = STRENGHT;
               DropShadowFilter(_loc2_).quality = QULITY;
               DropShadowFilter(_loc2_).inner = INNER;
               DropShadowFilter(_loc2_).knockout = KNOCKOUT;
               DropShadowFilter(_loc2_).hideObject = HIDE_OBJECT;
               this.tankNameBg.visible = this.showName;
            }
            else
            {
               _loc1_ = PREMIUM_TEXT_COLOR;
               _loc2_ = new GlowFilter(PREMIUM_TEXT_COLOR,PREMIUM_ALPHA,PREMIUM_BLUR_X,PREMIUM_BLUR_Y,PREMIUM_STRENGHT,QULITY,INNER,KNOCKOUT);
               this.tankNameBg.visible = false;
            }
            this.tankNameField.filters = [_loc2_];
            this.tankNameField.textColor = _loc1_;
         }
         else
         {
            this.tankNameField.filters = [];
         }
      }
      
      [Inspectable(defaultValue="false",verbose="1")]
      public function get favorite() : Boolean
      {
         return this._favorite;
      }
      
      public function set favorite(param1:Boolean) : void
      {
         if(this._favorite == param1)
         {
            return;
         }
         this._favorite = param1;
         this._favoriteDirty = true;
         invalidate();
      }
      
      [Inspectable(defaultValue="false",verbose="1")]
      public function get showMultyXp() : Boolean
      {
         return this._showMultyXp;
      }
      
      public function set showMultyXp(param1:Boolean) : void
      {
         this._showMultyXp = param1;
         this._showMultyXpDirty = true;
         invalidate();
      }
      
      [Inspectable(defaultValue="false",verbose="1")]
      public function get showXp() : Boolean
      {
         return this._showXp;
      }
      
      public function set showXp(param1:Boolean) : void
      {
         this._showXp = param1;
         this._showXpDirty = true;
         invalidate();
      }
      
      [Inspectable(defaultValue="false",verbose="1")]
      public function get showName() : Boolean
      {
         return this._showName;
      }
      
      public function set showName(param1:Boolean) : void
      {
         this._showName = param1;
         this._showNameDirty = true;
         invalidate();
      }
      
      [Inspectable(defaultValue="0",verbose="1")]
      public function get nation() : Number
      {
         return this._nation;
      }
      
      public function set nation(param1:Number) : void
      {
         if(param1 < 0 || param1 == this._nation)
         {
            return;
         }
         this._nation = param1;
         this._nationDirty = true;
         this._nationNameDirty = false;
         invalidate();
      }
      
      [Inspectable]
      public function get nationName() : String
      {
         return this._nationName;
      }
      
      public function set nationName(param1:String) : void
      {
         if(!param1 || param1 == this._nationName)
         {
            return;
         }
         this._nationName = param1;
         this._nationNameDirty = true;
         this._nationDirty = false;
         invalidate();
      }
      
      [Inspectable(defaultValue="",verbose="1")]
      public function get image() : String
      {
         return this._image;
      }
      
      public function set image(param1:String) : void
      {
         if(!param1 || param1 == this._image)
         {
            return;
         }
         this._image = param1;
         this._imageDirty = true;
         invalidate();
      }
      
      [Inspectable(defaultValue="lightTank",type="list",enumeration="lightTank,mediumTank,heavyTank,AT-SPG,SPG")]
      public function get tankType() : String
      {
         return this._tankType;
      }
      
      public function set tankType(param1:String) : void
      {
         if(!param1 || param1 == this._tankType)
         {
            return;
         }
         this._tankType = param1;
         this._tankTypeDirty = true;
         invalidate();
      }
      
      [Inspectable(defaultValue="1",verbose="1")]
      public function get level() : Number
      {
         return this._level;
      }
      
      public function set level(param1:Number) : void
      {
         if(param1 == this._level)
         {
            return;
         }
         this._level = param1;
         this._levelDirty = true;
         invalidate();
      }
      
      [Inspectable(defaultValue="1",verbose="1")]
      public function get multyXpVal() : Number
      {
         return this._multyXpVal;
      }
      
      public function set multyXpVal(param1:Number) : void
      {
         if(param1 == this._multyXpVal)
         {
            return;
         }
         this._multyXpVal = param1;
         this._multyXpValDirty = true;
         invalidate();
      }
      
      [Inspectable(defaultValue="0",verbose="1")]
      public function get xpVal() : Number
      {
         return this._xpVal;
      }
      
      public function set xpVal(param1:Number) : void
      {
         if(param1 == this._xpVal)
         {
            return;
         }
         this._xpVal = param1;
         this._xpValDirty = true;
         invalidate();
      }
      
      [Inspectable(defaultValue="",verbose="1")]
      public function get tankName() : String
      {
         return this._tankName;
      }
      
      public function set tankName(param1:String) : void
      {
         if(param1 == this._tankName)
         {
            return;
         }
         this._tankName = param1;
         this._tankNameDirty = true;
         invalidate();
      }
      
      [Inspectable(defaultValue="false",verbose="1")]
      public function get isElite() : Boolean
      {
         return this._isElite;
      }
      
      public function set isElite(param1:Boolean) : void
      {
         if(param1 == this._isElite)
         {
            return;
         }
         this._isElite = param1;
         this._isEliteDirty = true;
         invalidate();
      }
      
      [Inspectable(defaultValue="false",verbose="1")]
      public function get isPremium() : Boolean
      {
         return this._isPremium;
      }
      
      public function set isPremium(param1:Boolean) : void
      {
         if(param1 == this._isPremium)
         {
            return;
         }
         this._isPremium = param1;
         this._isPremiumDirty = true;
         invalidate();
      }
      
      [Inspectable(defaultValue="",verbose="1")]
      public function get rentInfo() : String
      {
         return this._rentInfo;
      }
      
      public function set rentInfo(param1:String) : void
      {
         this._rentInfo = param1;
         this._isRentDirty = true;
         invalidate();
      }
      
      public function get isForCompare() : Boolean
      {
         return this._isForCompare;
      }
      
      public function set isForCompare(param1:Boolean) : void
      {
         this._isForCompare = param1;
      }
   }
}
