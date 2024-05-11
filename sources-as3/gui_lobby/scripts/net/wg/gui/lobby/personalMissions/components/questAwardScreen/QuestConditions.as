package net.wg.gui.lobby.personalMissions.components.questAwardScreen
{
   import fl.motion.easing.Quintic;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import net.wg.data.constants.generated.QUEST_PROGRESS_BASE;
   import net.wg.gui.components.questProgress.QuestProgressConstsBase;
   import net.wg.gui.components.questProgress.interfaces.components.IHeaderProgressItem;
   import net.wg.gui.components.questProgress.interfaces.components.IQPItemOrConditionIcon;
   import net.wg.gui.components.questProgress.interfaces.components.IQPItemRenderer;
   import net.wg.gui.components.questProgress.interfaces.data.IHeaderProgressData;
   import net.wg.gui.components.questProgress.interfaces.data.IQuestProgressItemData;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.motion.Tween;
   
   public class QuestConditions extends UIComponentEx
   {
      
      private static const CONDITIONS_GAP:int = 35;
      
      private static const CONDITIONS_GAP_AFTER_OR_ITEM:int = 6;
      
      private static const OR_ITEM_SHIFT_X:int = -7;
      
      private static const OR_Y_POS:int = 50;
      
      private static const SEPARATOR_GAP:int = 32;
      
      private static const AFTER_SEPARATOR_GAP:int = 52;
      
      private static const HEADER_PROGRESS_WIDTH:int = 700;
      
      private static const HEADER_PROGRESS_SMALL_WIDTH:int = 420;
      
      private static const HEADER_PROGRESS_Y:int = 25;
      
      private static const HEADER_PROGRESS_SEPARATOR_GAP:int = 38;
      
      private static const ANIM_DURATION:int = 600;
      
      private static const ANIM_Y_OFFSET:int = 30;
      
      private static const ANIM_DELAY:int = 150;
       
      
      public var separator:Sprite = null;
      
      private var _mainConditions:Vector.<IQPItemRenderer> = null;
      
      private var _addConditions:Vector.<IQPItemRenderer> = null;
      
      private var _mainHeaderProgressItem:IHeaderProgressItem = null;
      
      private var _addHeaderProgressItem:IHeaderProgressItem = null;
      
      private var _mainConditionsData:Vector.<IQuestProgressItemData> = null;
      
      private var _addConditionsData:Vector.<IQuestProgressItemData> = null;
      
      private var _mainHeaderProgressData:IHeaderProgressData = null;
      
      private var _addHeaderProgressData:IHeaderProgressData = null;
      
      private var _orItemsMain:Vector.<IQPItemOrConditionIcon> = null;
      
      private var _orItemsAdd:Vector.<IQPItemOrConditionIcon> = null;
      
      private var _hasMainConditions:Boolean = false;
      
      private var _hasAddConditions:Boolean = false;
      
      private var _hasMainHeaderProgress:Boolean = false;
      
      private var _hasAddHeaderProgress:Boolean = false;
      
      private var _tweens:Vector.<Tween> = null;
      
      public function QuestConditions()
      {
         super();
      }
      
      private static function layoutConditions(param1:Vector.<IQPItemRenderer>, param2:Vector.<IQPItemOrConditionIcon>, param3:int = 0) : void
      {
         var _loc5_:int = 0;
         var _loc6_:IQPItemRenderer = null;
         var _loc7_:IQPItemOrConditionIcon = null;
         var _loc4_:int = param3;
         for each(_loc6_ in param1)
         {
            _loc6_.x = _loc4_;
            _loc5_ = CONDITIONS_GAP;
            for each(_loc7_ in param2)
            {
               if(_loc6_ == _loc7_.previousItem)
               {
                  _loc5_ = CONDITIONS_GAP_AFTER_OR_ITEM;
                  _loc7_.x = _loc6_.x + _loc6_.width + OR_ITEM_SHIFT_X;
                  break;
               }
            }
            _loc4_ += _loc6_.width + _loc5_;
         }
      }
      
      private static function cleanHeaderProgressItem(param1:IHeaderProgressItem) : void
      {
         if(param1 != null)
         {
            param1.dispose();
         }
      }
      
      private static function createTween(param1:Object, param2:uint) : Tween
      {
         return new Tween(ANIM_DURATION,param1,{
            "alpha":1,
            "y":param1.y - ANIM_Y_OFFSET
         },{
            "paused":false,
            "delay":param2 * ANIM_DELAY,
            "ease":Quintic.easeOut
         });
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._tweens = new Vector.<Tween>(0);
         this.separator.alpha = 0;
      }
      
      override protected function draw() : void
      {
         var _loc1_:DisplayObject = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            if(this._hasMainConditions)
            {
               this.cleanOrItems(this._orItemsMain);
               this.cleanConditions(this._mainConditions);
               this._mainConditions = new Vector.<IQPItemRenderer>(0);
               this._orItemsMain = new Vector.<IQPItemOrConditionIcon>();
               this.createConditions(this._mainConditions,this._mainConditionsData,this._orItemsMain);
            }
            else if(this._hasMainHeaderProgress)
            {
               cleanHeaderProgressItem(this._mainHeaderProgressItem);
               this._mainHeaderProgressItem = this.createHeaderProgressItem(this._mainHeaderProgressData,this._hasAddConditions || this._hasAddHeaderProgress);
            }
            if(this._hasAddConditions)
            {
               this.cleanOrItems(this._orItemsAdd);
               this.cleanConditions(this._addConditions);
               this._addConditions = new Vector.<IQPItemRenderer>(0);
               this._orItemsAdd = new Vector.<IQPItemOrConditionIcon>();
               this.createConditions(this._addConditions,this._addConditionsData,this._orItemsAdd);
            }
            else if(this._hasAddHeaderProgress)
            {
               cleanHeaderProgressItem(this._addHeaderProgressItem);
               this._addHeaderProgressItem = this.createHeaderProgressItem(this._addHeaderProgressData,this._hasMainConditions || this._hasMainHeaderProgress);
            }
            this.separator.visible = (this._hasMainConditions || this._hasMainHeaderProgress) && (this._hasAddConditions || this._hasAddHeaderProgress);
            invalidateSize();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            _loc1_ = null;
            _loc2_ = SEPARATOR_GAP;
            _loc3_ = 0;
            if(this._hasMainConditions)
            {
               layoutConditions(this._mainConditions,this._orItemsMain);
               _loc1_ = DisplayObject(this._mainConditions[this._mainConditions.length - 1]);
               _loc3_ = _loc1_.width;
            }
            else if(this._hasMainHeaderProgress)
            {
               _loc1_ = DisplayObject(this._mainHeaderProgressItem);
               _loc2_ = HEADER_PROGRESS_SEPARATOR_GAP;
               _loc3_ = this._hasAddConditions || this._hasAddHeaderProgress ? int(HEADER_PROGRESS_SMALL_WIDTH) : int(HEADER_PROGRESS_WIDTH);
            }
            if(this.separator.visible)
            {
               this.separator.x = _loc1_.x + _loc3_ + _loc2_ | 0;
               _loc1_ = this.separator;
               _loc3_ = this.separator.width;
            }
            if(this._hasAddConditions)
            {
               layoutConditions(this._addConditions,this._orItemsAdd,this.separator.x + this.separator.width + AFTER_SEPARATOR_GAP | 0);
               _loc1_ = DisplayObject(this._addConditions[this._addConditions.length - 1]);
               _loc3_ = _loc1_.width;
            }
            else if(this._hasAddHeaderProgress)
            {
               if(_loc1_ != null)
               {
                  this._addHeaderProgressItem.x = _loc1_.x + _loc3_ + HEADER_PROGRESS_SEPARATOR_GAP | 0;
               }
               _loc1_ = DisplayObject(this._addHeaderProgressItem);
               _loc3_ = this._hasMainConditions || this._hasMainHeaderProgress ? int(HEADER_PROGRESS_SMALL_WIDTH) : int(HEADER_PROGRESS_WIDTH);
            }
            if(_loc1_ != null)
            {
               _width = _loc1_.x + _loc3_;
               dispatchEvent(new Event(Event.RESIZE));
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.disposeTweens();
         this._tweens = null;
         this.cleanOrItems(this._orItemsMain);
         this.cleanOrItems(this._orItemsAdd);
         this._orItemsMain = null;
         this._orItemsAdd = null;
         this.cleanConditions(this._mainConditions);
         this.cleanConditions(this._addConditions);
         this._mainConditions = null;
         this._addConditions = null;
         this.separator = null;
         this._mainConditionsData = null;
         this._addConditionsData = null;
         cleanHeaderProgressItem(this._mainHeaderProgressItem);
         cleanHeaderProgressItem(this._addHeaderProgressItem);
         this._mainHeaderProgressItem = null;
         this._addHeaderProgressItem = null;
         this._mainHeaderProgressData = null;
         this._addHeaderProgressData = null;
         super.onDispose();
      }
      
      public function setData(param1:Vector.<IQuestProgressItemData>, param2:Vector.<IQuestProgressItemData>, param3:IHeaderProgressData, param4:IHeaderProgressData) : void
      {
         this._hasMainConditions = this._hasAddConditions = this._hasMainHeaderProgress = this._hasAddHeaderProgress = false;
         if(param1 != null && param1.length > 0)
         {
            this._hasMainConditions = true;
            this._mainConditionsData = param1;
         }
         else if(param3 != null)
         {
            this._hasMainHeaderProgress = true;
            this._mainHeaderProgressData = param3;
         }
         if(param2 != null && param2.length > 0)
         {
            this._hasAddConditions = true;
            this._addConditionsData = param2;
         }
         else if(param4 != null)
         {
            this._hasAddHeaderProgress = true;
            this._addHeaderProgressData = param4;
         }
         if(this._hasMainConditions || this._hasAddConditions || this._hasMainHeaderProgress || this._hasAddHeaderProgress)
         {
            invalidateData();
         }
      }
      
      public function show() : void
      {
         var _loc1_:IQPItemRenderer = null;
         var _loc2_:IQPItemOrConditionIcon = null;
         this.disposeTweens();
         var _loc3_:uint = 0;
         if(this._hasMainConditions)
         {
            for each(_loc1_ in this._mainConditions)
            {
               _loc1_.y += ANIM_Y_OFFSET;
               this._tweens.push(createTween(_loc1_,_loc3_++));
               for each(_loc2_ in this._orItemsMain)
               {
                  if(_loc1_ == _loc2_.previousItem)
                  {
                     _loc2_.y += ANIM_Y_OFFSET;
                     this._tweens.push(createTween(_loc2_,_loc3_++));
                     break;
                  }
               }
            }
         }
         else if(this._hasMainHeaderProgress)
         {
            this._mainHeaderProgressItem.alpha = 0;
            this._mainHeaderProgressItem.y += ANIM_Y_OFFSET;
            this._tweens.push(createTween(this._mainHeaderProgressItem,_loc3_++));
         }
         this.separator.y += ANIM_Y_OFFSET;
         this._tweens.push(createTween(this.separator,_loc3_++));
         if(this._hasAddConditions)
         {
            for each(_loc1_ in this._addConditions)
            {
               _loc1_.y += ANIM_Y_OFFSET;
               this._tweens.push(createTween(_loc1_,_loc3_++));
               for each(_loc2_ in this._orItemsAdd)
               {
                  if(_loc1_ == _loc2_.previousItem)
                  {
                     _loc2_.y += ANIM_Y_OFFSET;
                     this._tweens.push(createTween(_loc2_,_loc3_++));
                     break;
                  }
               }
            }
         }
         else if(this._hasAddHeaderProgress)
         {
            this._addHeaderProgressItem.y += ANIM_Y_OFFSET;
            this._tweens.push(createTween(this._addHeaderProgressItem,_loc3_++));
         }
      }
      
      private function createHeaderProgressItem(param1:IHeaderProgressData, param2:Boolean) : IHeaderProgressItem
      {
         var _loc3_:String = QuestProgressConstsBase.getHeaderBigItemLinkage(param1.progressType);
         var _loc4_:IHeaderProgressItem = App.utils.classFactory.getComponent(_loc3_,IHeaderProgressItem);
         _loc4_.setData(param1,!!param2 ? int(HEADER_PROGRESS_SMALL_WIDTH) : int(HEADER_PROGRESS_WIDTH));
         _loc4_.y = HEADER_PROGRESS_Y;
         _loc4_.alpha = 0;
         addChild(DisplayObject(_loc4_));
         return _loc4_;
      }
      
      private function createConditions(param1:Vector.<IQPItemRenderer>, param2:Vector.<IQuestProgressItemData>, param3:Vector.<IQPItemOrConditionIcon>) : void
      {
         var _loc4_:IQPItemRenderer = null;
         var _loc5_:IQPItemRenderer = null;
         var _loc7_:IQuestProgressItemData = null;
         var _loc6_:IQPItemOrConditionIcon = null;
         for each(_loc7_ in param2)
         {
            _loc4_ = App.utils.classFactory.getComponent(QUEST_PROGRESS_BASE.QP_VIEW_RENDERER_QUEST_AWARD,IQPItemRenderer);
            _loc4_.viewType = QUEST_PROGRESS_BASE.VIEW_TYPE_QUEST_AWARD;
            _loc4_.id = _loc7_.id;
            _loc4_.init(_loc7_.initData);
            _loc4_.update(_loc7_.progressData);
            _loc4_.alpha = 0;
            param1.push(_loc4_);
            addChild(DisplayObject(_loc4_));
            if(_loc5_ && _loc5_.isInOrGroup && _loc4_.isInOrGroup)
            {
               _loc6_ = App.utils.classFactory.getComponent(QUEST_PROGRESS_BASE.QP_OR_CONDITION_ICON_AWARD,IQPItemOrConditionIcon);
               _loc6_.setItems(_loc5_,_loc4_);
               _loc6_.y = OR_Y_POS;
               _loc6_.alpha = 0;
               param3.push(_loc6_);
               addChild(DisplayObject(_loc6_));
            }
            _loc5_ = _loc4_;
         }
      }
      
      private function cleanConditions(param1:Vector.<IQPItemRenderer>) : void
      {
         var _loc2_:IUIComponentEx = null;
         if(param1 != null)
         {
            for each(_loc2_ in param1)
            {
               removeChild(DisplayObject(_loc2_));
               _loc2_.dispose();
            }
            param1.splice(0,param1.length);
            param1 = null;
         }
      }
      
      private function cleanOrItems(param1:Vector.<IQPItemOrConditionIcon>) : void
      {
         var _loc2_:IQPItemOrConditionIcon = null;
         if(param1)
         {
            for each(_loc2_ in param1)
            {
               removeChild(DisplayObject(_loc2_));
            }
            param1.splice(0,param1.length);
            param1 = null;
         }
      }
      
      private function disposeTweens() : void
      {
         var _loc1_:Tween = null;
         for each(_loc1_ in this._tweens)
         {
            _loc1_.paused = true;
            _loc1_.dispose();
         }
         this._tweens.splice(0,this._tweens.length);
      }
   }
}
