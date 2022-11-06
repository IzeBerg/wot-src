package net.wg.gui.lobby.battleResults.components
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.filters.ColorMatrixFilter;
   import flash.filters.DropShadowFilter;
   import net.wg.data.VO.AchievementItemVO;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.CoreListEx;
   import net.wg.gui.lobby.battleResults.data.BattleResultsMedalsListVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.data.ListData;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public class MedalsList extends CoreListEx
   {
      
      public static const ALIGN_RIGHT:String = "right";
      
      public static const ALIGN_CENTER:String = "center";
      
      public static const ALIGN_LEFT:String = "left";
      
      private static const SPECIAL_ICON_PROP_NAME:String = "specialIcon";
      
      private static const IS_EPIC_PROP_NAME:String = "isEpic";
      
      private static const DROP_SHADOW_COLOR:uint = 0;
      
      private static const DROP_SHADOW_ALPHA:Number = 0.75;
      
      private static const DROP_SHADOW_BLUR:Number = 4;
      
      private static const DROP_SHADOW_ANGLE:Number = 90;
      
      private static const DROP_SHADOW_DISTANCE:Number = 2;
      
      private static const RENDERER_PADDING:int = 2;
       
      
      public var stripesContainer:DisplayObjectContainer;
      
      private var _align:String = "left";
      
      private var _gap:Number = 0;
      
      private var _colorDodgeMulty:Number = 1.3;
      
      private var _stripes:Vector.<SpecialAchievement>;
      
      private var _paddings:Object;
      
      public function MedalsList()
      {
         this._paddings = {};
         super();
         this._paddings[CustomAchievement.TYPE_MARK_OF_GUN] = 40;
         this._stripes = new Vector.<SpecialAchievement>(0);
      }
      
      private static function isDisplaySpecial(param1:Object) : Boolean
      {
         var _loc2_:Boolean = param1[IS_EPIC_PROP_NAME];
         var _loc3_:Boolean = param1[SPECIAL_ICON_PROP_NAME] != Values.EMPTY_STR;
         return _loc2_ || _loc3_;
      }
      
      override protected function drawLayout() : void
      {
         var _loc4_:int = 0;
         var _loc5_:IListItemRenderer = null;
         var _loc7_:int = 0;
         var _loc9_:Number = NaN;
         var _loc1_:int = RENDERER_PADDING;
         var _loc2_:uint = _renderers.length;
         var _loc3_:int = 0;
         var _loc6_:Boolean = isInvalid(InvalidationType.DATA);
         for each(_loc5_ in _renderers)
         {
            _loc4_ = this.getPersonalPadding(_loc5_);
            _loc3_ += _loc5_.width + _loc1_ + _loc4_;
         }
         _loc3_ -= _loc1_;
         if(_loc3_ > width)
         {
            this._gap = (width - _loc3_) / (_loc2_ - 1) ^ 0;
         }
         if(this._align == ALIGN_RIGHT)
         {
            _loc7_ = width - (_loc2_ > 0 ? _loc5_.width : 0);
         }
         else if(this._align == ALIGN_CENTER)
         {
            _loc7_ = width - _loc3_ >> 1;
            if(_loc7_ < 0)
            {
               _loc7_ = 0;
            }
         }
         else if(this._align == ALIGN_LEFT)
         {
            _loc7_ = 0;
         }
         var _loc8_:uint = 0;
         while(_loc8_ < _loc2_)
         {
            _loc5_ = getRendererAt(_loc8_);
            _loc4_ = this.getPersonalPadding(_loc5_);
            _loc5_.x = _loc7_ - (_loc4_ >> 1);
            _loc5_.y = height - _loc5_.height >> 1;
            _loc9_ = _loc1_ + _loc4_ + _loc5_.width + this._gap;
            _loc7_ += this._align == ALIGN_RIGHT ? -_loc9_ : _loc9_;
            if(!_loc6_)
            {
               _loc5_.validateNow();
            }
            _loc8_++;
         }
      }
      
      override protected function refreshData() : void
      {
         _dataProvider.requestItemRange(0,Math.min(_dataProvider.length - 1,_totalRenderers - 1),this.populateData);
      }
      
      override protected function calculateRendererTotal(param1:Number, param2:Number) : uint
      {
         return _dataProvider.length;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.updateFilters();
      }
      
      override protected function onDispose() : void
      {
         this.removeStripes();
         this._paddings = null;
         this._stripes = null;
         this.stripesContainer = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         if(dataProvider && !_usingExternalRenderers && isInvalid(InvalidationType.DATA))
         {
            _totalRenderers = dataProvider.length;
            invalidateRenderers();
         }
         super.draw();
         if(!_usingExternalRenderers && isInvalid(InvalidationType.SIZE))
         {
            container.scaleX = container.scaleY = 1;
            this.stripesContainer.scaleX = this.stripesContainer.scaleY = 1;
         }
      }
      
      protected function populateData(param1:Array) : void
      {
         var _loc5_:IListItemRenderer = null;
         var _loc6_:AchievementItemVO = null;
         var _loc7_:ListData = null;
         if(_baseDisposed)
         {
            return;
         }
         this.removeStripes();
         var _loc2_:int = param1.length;
         var _loc3_:int = _renderers.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = getRendererAt(_loc4_);
            _loc6_ = AchievementItemVO(param1[_loc4_]);
            _loc7_ = new ListData(_loc4_,itemToLabel(_loc6_),_selectedIndex == _loc4_);
            _loc5_.enabled = _loc4_ < _loc2_;
            _loc5_.setListData(_loc7_);
            _loc5_.setData(_loc6_);
            _loc5_.validateNow();
            if(_loc6_ is BattleResultsMedalsListVO && isDisplaySpecial(_loc6_))
            {
               this.createStripeRenderer(_loc6_);
            }
            _loc4_++;
         }
         this.drawLayout();
         this.stripesUpdatePosition();
      }
      
      protected function updateFilters() : void
      {
         var _loc1_:Array = [];
         _loc1_ = _loc1_.concat([this._colorDodgeMulty,0,0,0,0]);
         _loc1_ = _loc1_.concat([0,this._colorDodgeMulty,0,0,0]);
         _loc1_ = _loc1_.concat([0,0,this._colorDodgeMulty,0,0]);
         _loc1_ = _loc1_.concat([0,0,0,1,0]);
         var _loc2_:ColorMatrixFilter = new ColorMatrixFilter();
         _loc2_.matrix = _loc1_;
         var _loc3_:DropShadowFilter = new DropShadowFilter(DROP_SHADOW_DISTANCE,DROP_SHADOW_ANGLE,DROP_SHADOW_COLOR,DROP_SHADOW_ALPHA,DROP_SHADOW_BLUR,DROP_SHADOW_BLUR);
         container.filters = [_loc2_,_loc3_];
         this.stripesContainer.filters = [_loc3_];
      }
      
      private function getPersonalPadding(param1:IListItemRenderer) : int
      {
         var _loc2_:Object = param1.getData();
         return _loc2_ && this._paddings.hasOwnProperty(_loc2_.type) ? int(this._paddings[_loc2_.type]) : int(0);
      }
      
      private function removeStripes() : void
      {
         var _loc1_:UIComponentEx = null;
         for each(_loc1_ in this._stripes)
         {
            _loc1_.dispose();
            this.stripesContainer.removeChild(_loc1_);
         }
         this._stripes.splice(0,this._stripes.length);
      }
      
      private function createStripeRenderer(param1:Object) : void
      {
         var _loc2_:SpecialAchievement = App.utils.classFactory.getComponent(Linkages.ACHIEVEMENT_STRIPE,SpecialAchievement);
         this.stripesContainer.addChild(_loc2_);
         this._stripes.push(_loc2_);
         _loc2_.data = param1;
         _loc2_.validateNow();
      }
      
      private function stripesUpdatePosition() : void
      {
         var _loc2_:SpecialAchievement = null;
         var _loc3_:DisplayObject = null;
         var _loc1_:int = this._stripes.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc1_)
         {
            _loc2_ = this._stripes[_loc4_];
            _loc3_ = DisplayObject(_renderers[_loc4_]);
            _loc2_.x = _loc3_.x + (_loc3_.width - _loc2_.width >> 1);
            _loc2_.y = _loc3_.y + (_loc3_.height - _loc2_.height >> 1);
            _loc4_++;
         }
      }
      
      [Inspectable(defaultValue="left",name="alignTo",enumeration="left,right,center")]
      public function get align() : String
      {
         return this._align;
      }
      
      public function set align(param1:String) : void
      {
         this._align = param1;
      }
      
      [Inspectable(defaultValue="0",name="gap",type="Number",verbose="1")]
      public function get gap() : Number
      {
         return this._gap;
      }
      
      public function set gap(param1:Number) : void
      {
         this._gap = param1;
      }
      
      [Inspectable(defaultValue="1.3",name="colorDodgeMulty",type="Number",verbose="1")]
      public function get colorDodgeMulty() : Number
      {
         return this._colorDodgeMulty;
      }
      
      public function set colorDodgeMulty(param1:Number) : void
      {
         this._colorDodgeMulty = param1;
      }
      
      override protected function handleDataChange(param1:Event) : void
      {
         super.handleDataChange(param1);
         invalidateSize();
      }
   }
}
