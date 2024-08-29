package net.wg.gui.lobby.hangar.quests
{
   import fl.motion.easing.Quartic;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import net.wg.data.Aliases;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.HANGAR_HEADER_QUESTS;
   import net.wg.gui.lobby.hangar.data.HeaderQuestGroupVO;
   import net.wg.gui.lobby.hangar.data.HeaderQuestsVO;
   import net.wg.gui.lobby.hangar.interfaces.IHeaderQuestsContainer;
   import net.wg.gui.lobby.hangar.interfaces.IQuestInformerButton;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.motion.Tween;
   
   public class HeaderQuestsContainer extends Sprite implements IHeaderQuestsContainer
   {
      
      private static const TWEEN_DURATION:int = 400;
      
      private static const ICON_TWEEN_DELAY:int = 200;
      
      private static const ICON_TWEEN_DURATION:int = 300;
      
      private static const ICON_TWEEN_ALPHA:int = 1;
      
      private static const ICON_TWEEN_SCALE:int = 1;
      
      private static const ICON_TWEEN_SCALE_BEFORE:int = 3;
      
      private static const ICON_TWEEN_ALPHA_BEFORE:int = 0;
      
      private static const GROUPED_FLAG_START_Y:int = -5;
      
      private static const GROUP_ICON_SHIFT_X:int = 23;
      
      private static const GROUP_ICON_SHIFT_Y:int = 37;
      
      private static const SHOW_CONTENT_DELAY_STEP_INDEX:int = 100;
       
      
      private var _questsInformers:Vector.<IQuestInformerButton> = null;
      
      private var _itemsTween:Vector.<Tween> = null;
      
      private var _isAnimExpanded:Boolean = false;
      
      private var _isAllQuestsItemsDisabled:Boolean = false;
      
      private var _groupID:String = "";
      
      private var _icon:QuestFlagIconContainer = null;
      
      private var _iconTweenShow:Tween = null;
      
      private var _isSingle:Boolean = true;
      
      private var _questsMap:Dictionary;
      
      private var _isRightSide:Boolean = false;
      
      private var _maskMc:Sprite = null;
      
      private var _disposed:Boolean = false;
      
      private var _pos:Point = null;
      
      private var _tween:Tween = null;
      
      private var _isInited:Boolean = false;
      
      private var _minContainerX:int = 0;
      
      public function HeaderQuestsContainer()
      {
         this._questsMap = new Dictionary();
         super();
         mouseEnabled = false;
      }
      
      private static function animFlagContent(param1:IQuestInformerButton, param2:Boolean, param3:int) : void
      {
         if(param2)
         {
            param1.showContent(false,SHOW_CONTENT_DELAY_STEP_INDEX * param3);
         }
         else
         {
            param1.hideContent(false,SHOW_CONTENT_DELAY_STEP_INDEX * param3);
         }
      }
      
      public final function animCollapse() : void
      {
         if(!this._isSingle && this._isAnimExpanded)
         {
            this._isAnimExpanded = false;
            this.onAnimQuests(this._questsInformers,false);
         }
      }
      
      public final function animExpand() : void
      {
         if(!this._isSingle && !this._isAnimExpanded)
         {
            this._isAnimExpanded = true;
            this.onAnimQuests(this._questsInformers,true);
         }
      }
      
      public function animPosition(param1:int, param2:Object) : void
      {
         this.clearTween();
         if(this._isInited)
         {
            this._tween = new Tween(param1,this,{
               "x":this._pos.x,
               "y":this._pos.y
            },param2);
         }
         else
         {
            this.x = this._pos.x;
            this.y = this._pos.y;
         }
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.clearQuests();
         this.clearIcon();
         App.utils.data.cleanupDynamicObject(this._questsMap);
         this._questsMap = null;
         this.clearTweens();
         this.clearAnimIcon();
         this.clearTween();
         this._pos = null;
         this._maskMc = null;
      }
      
      public function getQuestBtnByType(param1:String) : IQuestInformerButton
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(this._questsInformers)
         {
            _loc2_ = this._questsInformers.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               if(this._questsInformers[_loc3_].questType == param1)
               {
                  return this._questsInformers[_loc3_];
               }
               _loc3_++;
            }
         }
         return null;
      }
      
      public function hasInformersEqualNewData(param1:HeaderQuestGroupVO) : Boolean
      {
         var _loc4_:HeaderQuestsVO = null;
         var _loc5_:* = null;
         if(!param1)
         {
            return false;
         }
         var _loc2_:Vector.<HeaderQuestsVO> = param1.getQuests;
         var _loc3_:Vector.<String> = new Vector.<String>();
         for each(_loc4_ in _loc2_)
         {
            if(!this.getQuestInformerByType(_loc4_.questType))
            {
               return false;
            }
            _loc3_.push(_loc4_.questType);
         }
         if(this._questsMap)
         {
            for(_loc5_ in this._questsMap)
            {
               if(_loc3_.indexOf(_loc5_) == -1)
               {
                  return false;
               }
            }
         }
         return true;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public final function setData(param1:HeaderQuestGroupVO) : void
      {
         if(param1 == null)
         {
            return;
         }
         this._groupID = param1.groupID;
         this._isRightSide = param1.isRightSide;
         this.doUpdates(param1.getQuests,param1.groupIcon);
      }
      
      public function getMinX() : int
      {
         return this._minContainerX + x;
      }
      
      private function doUpdates(param1:Vector.<HeaderQuestsVO>, param2:String) : void
      {
         if(!this._questsInformers)
         {
            this._questsInformers = new Vector.<IQuestInformerButton>();
            this.createQuests(param1,param2);
         }
         else
         {
            this.updateQuests(param1,param2);
         }
      }
      
      private function createQuests(param1:Vector.<HeaderQuestsVO>, param2:String) : void
      {
         var _loc6_:HeaderQuestsVO = null;
         var _loc7_:int = 0;
         var _loc3_:IQuestInformerButton = null;
         var _loc4_:int = param1.length;
         var _loc5_:int = _loc4_ - 1;
         if(this._isRightSide)
         {
            param1 = param1.reverse();
         }
         if(_loc4_)
         {
            this._isSingle = _loc4_ == 1;
            this._isAllQuestsItemsDisabled = true;
            _loc7_ = 0;
            while(_loc7_ < _loc4_)
            {
               _loc3_ = App.utils.classFactory.getComponent(HANGAR_HEADER_QUESTS.HANGAR_QUEST_FLAG_LINKAGE,IQuestInformerButton);
               _loc6_ = param1[_loc7_];
               _loc3_.name = _loc6_.questType;
               _loc3_.setData(_loc6_,this._isRightSide);
               this.initQuestFlag(_loc3_,_loc7_,(_loc5_ - _loc7_) * GROUPED_FLAG_START_Y,_loc7_ == _loc5_);
               this._questsMap[_loc6_.questType] = _loc3_;
               addChild(DisplayObject(_loc3_));
               this._isAllQuestsItemsDisabled = this._isAllQuestsItemsDisabled && !_loc6_.enable;
               _loc7_++;
            }
            if(!this._isSingle || StringUtils.isNotEmpty(param2) && StringUtils.isEmpty(param1[0].icon))
            {
               this.clearIcon();
               this.addIcon(_loc3_,param2);
               this._icon.enabled = !this._isAllQuestsItemsDisabled;
            }
         }
      }
      
      private function updateQuests(param1:Vector.<HeaderQuestsVO>, param2:String) : void
      {
         var _loc3_:IQuestInformerButton = null;
         var _loc4_:HeaderQuestsVO = null;
         if(param1)
         {
            this._isAllQuestsItemsDisabled = true;
            for each(_loc4_ in param1)
            {
               _loc3_ = this.getQuestInformerByType(_loc4_.questType);
               if(_loc3_)
               {
                  _loc3_.setData(_loc4_,this._isRightSide);
               }
               this._isAllQuestsItemsDisabled = this._isAllQuestsItemsDisabled && !_loc4_.enable;
            }
            if(this._icon)
            {
               this._icon.setIcon(param2);
               this._icon.enabled = !this._isAllQuestsItemsDisabled;
            }
         }
      }
      
      private function initQuestFlag(param1:IQuestInformerButton, param2:int, param3:int = 0, param4:Boolean = false) : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         param1.addEventListener(ButtonEvent.CLICK,this.onQuestFlagClickHandler);
         param1.addEventListener(MouseEvent.ROLL_OVER,this.onQuestFlagRollOverHandler);
         this._questsInformers.push(param1);
         if(this._isSingle)
         {
            if(this._isRightSide)
            {
               _loc5_ = _loc6_ = Values.ZERO;
            }
            else
            {
               _loc5_ = _loc6_ = -HEADER_QUESTS_CONSTANTS.QUEST_BUTTONS_STEP;
            }
         }
         else
         {
            if(this._isRightSide)
            {
               _loc5_ = param2 * HEADER_QUESTS_CONSTANTS.QUEST_BUTTONS_GROUP_STEP;
            }
            else
            {
               _loc5_ = -HEADER_QUESTS_CONSTANTS.QUEST_BUTTONS_STEP - param2 * HEADER_QUESTS_CONSTANTS.QUEST_BUTTONS_GROUP_STEP;
            }
            _loc6_ = (param2 + (!!this._isRightSide ? 0 : 1)) * HEADER_QUESTS_CONSTANTS.QUEST_BUTTONS_STEP * (!!this._isRightSide ? 1 : -1);
            if(!param4)
            {
               this.addMask(param1,_loc5_);
            }
            param1.hideContent(true,0);
         }
         param1.x = _loc5_;
         param1.y = param3;
         param1.setCollapsePoint(_loc5_,param3);
         param1.setExpandPoint(_loc6_,Values.ZERO);
         if(this._minContainerX > _loc6_)
         {
            this._minContainerX = _loc6_;
         }
      }
      
      private function addMask(param1:IQuestInformerButton, param2:int) : void
      {
         this._maskMc = App.utils.classFactory.getComponent(Aliases.HEADER_QUEST_FLAG_MASK,Sprite);
         this._maskMc.x = param2;
         if(this._isRightSide)
         {
            this._maskMc.x += HEADER_QUESTS_CONSTANTS.QUEST_BUTTONS_GROUP_STEP - this._maskMc.width;
         }
         else
         {
            this._maskMc.x += HEADER_QUESTS_CONSTANTS.QUEST_BUTTONS_MASK_X_SHIFT_COLLAPSE;
         }
         addChild(this._maskMc);
         param1.mask = this._maskMc;
      }
      
      private function getQuestInformerByType(param1:String) : IQuestInformerButton
      {
         return param1 in this._questsMap ? this._questsMap[param1] : null;
      }
      
      private function onLastItemAnimationComplete() : void
      {
         dispatchEvent(new HeaderQuestsEvent(HeaderQuestsEvent.ANIM_END,Values.EMPTY_STR,Values.EMPTY_STR,this._isAllQuestsItemsDisabled,this._isSingle));
      }
      
      private function onAnimQuests(param1:Vector.<IQuestInformerButton>, param2:Boolean) : void
      {
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         dispatchEvent(new HeaderQuestsEvent(HeaderQuestsEvent.ANIM_START,Values.EMPTY_STR,Values.EMPTY_STR,this._isAllQuestsItemsDisabled,this._isSingle));
         this.clearTweens();
         this._itemsTween = new Vector.<Tween>();
         var _loc3_:int = param1.length;
         var _loc4_:IQuestInformerButton = null;
         var _loc5_:Point = null;
         var _loc6_:Point = null;
         if(_loc3_)
         {
            _loc7_ = _loc3_ - 1;
            _loc8_ = _loc7_;
            _loc9_ = 0;
            while(_loc9_ < _loc3_)
            {
               _loc4_ = param1[_loc9_];
               _loc5_ = !!param2 ? _loc4_.expandPoint : _loc4_.collapsePoint;
               if(!this._isSingle)
               {
                  animFlagContent(_loc4_,param2,_loc8_);
               }
               this.addAnimItem(_loc4_,_loc5_,_loc8_ == _loc7_ ? this.onLastItemAnimationComplete : null);
               if(_loc4_.mask)
               {
                  if(param2)
                  {
                     _loc6_ = new Point(_loc5_.x - HEADER_QUESTS_CONSTANTS.QUESTS_BUTTON_GAP,Values.ZERO);
                  }
                  else
                  {
                     _loc6_ = new Point(_loc5_.x,Values.ZERO);
                     if(this._isRightSide)
                     {
                        _loc6_.x += HEADER_QUESTS_CONSTANTS.QUEST_BUTTONS_GROUP_STEP - this._maskMc.width;
                     }
                     else
                     {
                        _loc6_.x += HEADER_QUESTS_CONSTANTS.QUEST_BUTTONS_MASK_X_SHIFT_COLLAPSE;
                     }
                  }
                  this.addAnimItem(_loc4_.mask,_loc6_);
               }
               _loc9_++;
               _loc8_--;
            }
         }
         if(!this._isSingle)
         {
            this.animIcon(param2);
         }
      }
      
      private function addAnimItem(param1:Object, param2:Point, param3:Function = null) : void
      {
         var _loc4_:Tween = new Tween(TWEEN_DURATION,param1,{
            "x":param2.x,
            "y":param2.y
         },{
            "paused":false,
            "ease":Quartic.easeOut,
            "delay":0,
            "fastTransform":false,
            "onComplete":param3
         });
         this._itemsTween.push(_loc4_);
      }
      
      private function clearTweens() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(this._itemsTween)
         {
            _loc1_ = this._itemsTween.length;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               this._itemsTween[_loc2_].paused = true;
               this._itemsTween[_loc2_].dispose();
               _loc2_++;
            }
            this._itemsTween.splice(0,_loc1_);
            this._itemsTween = null;
         }
      }
      
      private function animIcon(param1:Boolean) : void
      {
         this.clearAnimIcon();
         if(param1)
         {
            this._icon.alpha = 0;
         }
         else
         {
            this._icon.scaleX = this._icon.scaleY = ICON_TWEEN_SCALE_BEFORE;
            this._icon.alpha = ICON_TWEEN_ALPHA_BEFORE;
            this._iconTweenShow = new Tween(ICON_TWEEN_DURATION,this._icon,{
               "scaleX":ICON_TWEEN_SCALE,
               "scaleY":ICON_TWEEN_SCALE,
               "alpha":ICON_TWEEN_ALPHA
            },{
               "paused":false,
               "ease":Quartic.easeOut,
               "delay":ICON_TWEEN_DELAY,
               "fastTransform":false
            });
         }
      }
      
      private function clearAnimIcon() : void
      {
         if(this._iconTweenShow)
         {
            this._iconTweenShow.dispose();
            this._iconTweenShow = null;
         }
      }
      
      private function clearIcon() : void
      {
         if(this._icon)
         {
            removeChild(this._icon);
            this._icon.dispose();
            this._icon = null;
         }
      }
      
      private function addIcon(param1:IQuestInformerButton, param2:String) : void
      {
         this._icon = App.utils.classFactory.getComponent(Aliases.HEADER_QUEST_FLAG_ICON,QuestFlagIconContainer);
         this._icon.x = param1.x + GROUP_ICON_SHIFT_X;
         this._icon.y = param1.y + GROUP_ICON_SHIFT_Y;
         this._icon.setIcon(param2);
         this._icon.mouseChildren = false;
         this._icon.mouseEnabled = false;
         addChild(this._icon);
      }
      
      private function clearQuests() : void
      {
         var _loc1_:int = 0;
         var _loc2_:IQuestInformerButton = null;
         var _loc3_:int = 0;
         if(this._questsInformers)
         {
            _loc1_ = this._questsInformers.length;
            _loc2_ = null;
            if(_loc1_)
            {
               _loc3_ = 0;
               while(_loc3_ < _loc1_)
               {
                  _loc2_ = this._questsInformers[_loc3_];
                  _loc2_.removeEventListener(ButtonEvent.CLICK,this.onQuestFlagClickHandler);
                  _loc2_.removeEventListener(MouseEvent.ROLL_OVER,this.onQuestFlagRollOverHandler);
                  if(_loc2_.mask)
                  {
                     removeChild(_loc2_.mask);
                     _loc2_.mask = null;
                  }
                  removeChild(DisplayObject(_loc2_));
                  _loc2_.dispose();
                  _loc2_ = null;
                  _loc3_++;
               }
               this._questsInformers.splice(0,_loc1_);
            }
            this._questsInformers = null;
         }
      }
      
      private function clearTween() : void
      {
         if(this._tween)
         {
            this._tween.dispose();
            this._tween = null;
         }
      }
      
      public function get isRightSide() : Boolean
      {
         return this._isRightSide;
      }
      
      public function get isAnimExpanded() : Boolean
      {
         return this._isAnimExpanded;
      }
      
      public function get cmptWidth() : int
      {
         var _loc1_:int = 0;
         if(this._isSingle)
         {
            return HEADER_QUESTS_CONSTANTS.QUEST_BUTTONS_STEP;
         }
         _loc1_ = this._questsInformers.length;
         if(this.isAnimExpanded)
         {
            return _loc1_ * HEADER_QUESTS_CONSTANTS.QUEST_BUTTONS_STEP;
         }
         return (_loc1_ - 1) * HEADER_QUESTS_CONSTANTS.QUEST_BUTTONS_GROUP_STEP + HEADER_QUESTS_CONSTANTS.QUEST_BUTTONS_STEP;
      }
      
      public function get groupID() : String
      {
         return this._groupID;
      }
      
      public function get position() : Point
      {
         return this._pos;
      }
      
      public function set position(param1:Point) : void
      {
         this._isInited = Boolean(this._pos);
         this._pos = param1;
      }
      
      private function onQuestFlagClickHandler(param1:ButtonEvent) : void
      {
         var _loc2_:IQuestInformerButton = param1.target as IQuestInformerButton;
         if(_loc2_)
         {
            dispatchEvent(new HeaderQuestsEvent(HeaderQuestsEvent.HEADER_QUEST_CLICK,_loc2_.questType,_loc2_.questID,!this._isAllQuestsItemsDisabled,this._isSingle));
         }
      }
      
      private function onQuestFlagRollOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:IQuestInformerButton = param1.target as IQuestInformerButton;
         if(_loc2_ && !this._isAnimExpanded)
         {
            dispatchEvent(new HeaderQuestsEvent(HeaderQuestsEvent.HEADER_QUEST_OVER,_loc2_.questType,_loc2_.questID,!this._isAllQuestsItemsDisabled,this._isSingle));
         }
      }
   }
}
