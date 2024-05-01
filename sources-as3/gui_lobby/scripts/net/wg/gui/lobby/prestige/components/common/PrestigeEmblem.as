package net.wg.gui.lobby.prestige.components.common
{
   import flash.display.DisplayObject;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.containers.Group;
   import net.wg.gui.components.containers.HorizontalGroupLayout;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class PrestigeEmblem extends UIComponentEx
   {
      
      public static const SIZE_EXTRA_SMALL:String = "extraSmall";
      
      public static const SIZE_SMALL:String = "small";
      
      public static const SIZE_MEDIUM:String = "medium";
      
      public static const PRESTIGE_MAXIMUM_TYPE:String = "prestige";
      
      private static const PRESTIGE_ENAMEL_TYPE:String = "enamel";
      
      private static const PRESTIGE_GOLD_TYPE:String = "gold";
      
      private static const DIGITS_GROUP_NAME:String = "digitsGroup";
      
      private static const EMBLEM_NAME:String = "emblemIcon";
      
      private static const INVALIDATE_EMBLEM:String = "invalidateEmblem";
      
      private static const INVALIDATE_LEVEL:String = "invalidateLevel";
       
      
      private var _emblem:UILoaderAlt = null;
      
      private var _digitsGroup:Group = null;
      
      private var _type:String = "";
      
      private var _grade:String = "";
      
      private var _level:String = "";
      
      private var _size:String = "extraSmall";
      
      private var _isMaximumEmblem:Boolean = false;
      
      public function PrestigeEmblem()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._emblem = new UILoaderAlt();
         this._emblem.name = EMBLEM_NAME;
         this._emblem.autoSize = false;
         this._emblem.addEventListener(UILoaderEvent.COMPLETE,this.onEmblemLoadCompleteHandler);
         addChild(this._emblem);
      }
      
      override protected function draw() : void
      {
         super.draw();
         var _loc1_:Boolean = isInvalid(InvalidationType.SIZE);
         if(_loc1_ || isInvalid(INVALIDATE_EMBLEM))
         {
            this._emblem.source = this.getEmblemIcon();
         }
         if(_loc1_ || isInvalid(INVALIDATE_LEVEL))
         {
            this.setDigitsGroup();
         }
         if(this._digitsGroup && isInvalid(InvalidationType.LAYOUT))
         {
            this._digitsGroup.x = this._emblem.width - this._digitsGroup.width >> 1;
            this._digitsGroup.y = this._emblem.height - this._digitsGroup.height >> 1;
         }
      }
      
      override protected function onDispose() : void
      {
         if(this._emblem)
         {
            removeChild(this._emblem);
            this._emblem.removeEventListener(UILoaderEvent.COMPLETE,this.onEmblemLoadCompleteHandler);
            this._emblem.dispose();
            this._emblem = null;
         }
         this.cleanDigitsGroup();
         super.onDispose();
      }
      
      public function setData(param1:String, param2:String, param3:String) : void
      {
         if(this._type != param1 || this._grade != param2)
         {
            this._type = param1;
            this._grade = param2;
            this._isMaximumEmblem = this._type == PRESTIGE_MAXIMUM_TYPE;
            invalidate(INVALIDATE_EMBLEM);
         }
         if(this._level != param3)
         {
            this._level = param3;
            invalidate(INVALIDATE_LEVEL);
         }
      }
      
      protected function onDigitImageLoaderCompleteHandler(param1:UILoaderEvent) : void
      {
         this._digitsGroup.invalidateLayout();
         this._digitsGroup.validateNow();
         invalidateLayout();
      }
      
      protected function onEmblemLoadCompleteHandler(param1:UILoaderEvent) : void
      {
         invalidateLayout();
      }
      
      private function getEmblemIcon() : String
      {
         var _loc1_:String = Values.EMPTY_STR;
         switch(this._size)
         {
            case SIZE_SMALL:
               _loc1_ = !!this._isMaximumEmblem ? RES_ICONS.MAPS_ICONS_PRESTIGE_EMBLEM_72X72_PRESTIGE : RES_ICONS.getSmallPrestigeEmblem(this._type,this._grade);
               break;
            case SIZE_MEDIUM:
               _loc1_ = !!this._isMaximumEmblem ? RES_ICONS.MAPS_ICONS_PRESTIGE_EMBLEM_170X124_PRESTIGE : RES_ICONS.getMediumPrestigeEmblem(this._type,this._grade);
               break;
            default:
               _loc1_ = !!this._isMaximumEmblem ? RES_ICONS.MAPS_ICONS_PRESTIGE_EMBLEM_48X48_PRESTIGE : RES_ICONS.getExtraSmallPrestigeEmblem(this._type,this._grade);
         }
         return _loc1_;
      }
      
      private function getDigitScrFunction() : Function
      {
         switch(this._size)
         {
            case SIZE_SMALL:
               return RES_ICONS.getSmallPrestigeEmblemDigit;
            case SIZE_MEDIUM:
               return RES_ICONS.getMediumPrestigeEmblemDigit;
            default:
               return RES_ICONS.getExtraSmallPrestigeEmblemDigit;
         }
      }
      
      private function setDigitsGroup() : void
      {
         var _loc5_:UILoaderAlt = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         this.cleanDigitsGroup();
         if(this._isMaximumEmblem || StringUtils.isEmpty(this._level))
         {
            return;
         }
         this._digitsGroup = new Group();
         this._digitsGroup.name = DIGITS_GROUP_NAME;
         this._digitsGroup.layout = new HorizontalGroupLayout();
         addChild(this._digitsGroup);
         var _loc1_:uint = this._level.length;
         var _loc2_:String = this._type == PRESTIGE_ENAMEL_TYPE ? PRESTIGE_GOLD_TYPE : this._type;
         var _loc3_:Function = this.getDigitScrFunction();
         var _loc4_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc1_)
         {
            _loc5_ = new UILoaderAlt();
            _loc5_.autoSize = false;
            _loc6_ = this._level.charAt(_loc4_);
            _loc7_ = _loc3_(_loc2_,_loc6_);
            if(_loc7_)
            {
               _loc5_.addEventListener(UILoaderEvent.COMPLETE,this.onDigitImageLoaderCompleteHandler);
               _loc5_.source = _loc7_;
            }
            this._digitsGroup.addChild(_loc5_);
            _loc4_++;
         }
         this._digitsGroup.validateNow();
      }
      
      private function cleanDigitsGroup() : void
      {
         if(this._digitsGroup == null)
         {
            return;
         }
         var _loc1_:int = 0;
         var _loc2_:DisplayObject = null;
         var _loc3_:uint = this._digitsGroup.numChildren;
         _loc1_ = 0;
         while(_loc1_ < _loc3_)
         {
            _loc2_ = this._digitsGroup.getChildAt(_loc1_);
            _loc2_.removeEventListener(UILoaderEvent.COMPLETE,this.onDigitImageLoaderCompleteHandler);
            _loc1_++;
         }
         removeChild(this._digitsGroup);
         this._digitsGroup.dispose();
         this._digitsGroup = null;
      }
      
      override public function get width() : Number
      {
         return this._emblem.width;
      }
      
      override public function get height() : Number
      {
         return this._emblem.height;
      }
      
      public function set size(param1:String) : void
      {
         if(this._size == param1)
         {
            return;
         }
         this._size = param1;
         invalidateSize();
      }
      
      public function get isMaximumGrade() : Boolean
      {
         return this._isMaximumEmblem;
      }
   }
}
