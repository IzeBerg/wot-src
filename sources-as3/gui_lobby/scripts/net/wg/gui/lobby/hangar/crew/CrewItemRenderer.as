package net.wg.gui.lobby.hangar.crew
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.ComponentState;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.SoundManagerStates;
   import net.wg.data.constants.generated.CONTEXT_MENU_HANDLER_TYPE;
   import net.wg.gui.components.controls.TileList;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.CrewEvent;
   import net.wg.gui.lobby.components.SmallSkillsList;
   import net.wg.gui.lobby.components.data.SkillsVO;
   import net.wg.gui.lobby.hangar.CrewDropDownEvent;
   import net.wg.infrastructure.events.TutorialEvent;
   import net.wg.infrastructure.interfaces.ITutorialCustomComponent;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.utils.ICommons;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.CoreList;
   import scaleform.clik.controls.DropdownMenu;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.data.ListData;
   import scaleform.clik.events.ComponentEvent;
   import scaleform.clik.events.ListEvent;
   import scaleform.clik.interfaces.IDataProvider;
   import scaleform.clik.interfaces.IListItemRenderer;
   import scaleform.clik.utils.Padding;
   
   public class CrewItemRenderer extends DropdownMenu implements IListItemRenderer, ITutorialCustomComponent
   {
      
      private static const SOUND_TYPE:String = "rendererNormal";
      
      private static const SOUND_ID:String = "";
      
      private static const MENU_WIDTH:Number = 368;
      
      private static const SCROLLBAR_PADDING:Number = 13;
      
      private static const DROPDOWN:String = "RecruitScrollingList";
      
      private static const DROPDOWN2:String = "RecruitScrollingList2";
      
      private static const ITEM_RENDERER:String = "RecruitItemRendererUI";
      
      private static const TANKMEN_ICONS_SMALL:String = "../maps/icons/tankmen/icons/small/";
      
      private static const TANKMEN_RANKS_SMALL:String = "../maps/icons/tankmen/ranks/small/";
      
      private static const TANKMEN_ROLES_SMALL:String = "../maps/icons/tankmen/roles/small/";
      
      private static const IMAGE_EXTENSION:String = ".png";
      
      private static const DOWN_MENU_DIRECTION:String = "down";
      
      private static const DEF_ROW_COUNT:int = 5;
      
      private static const EMPTY_LABEL:String = "empty";
      
      private static const SELECTED_TAB_INDEX:int = 2;
      
      private static const SPACE_DELIMITER:String = " ";
      
      private static const EMPTY_STR:String = "";
      
      private static const DROPDOWN_LIST_NAME:String = "dropDownList";
      
      private static const OVER_ANIMATION_END_FRAME:int = 19;
      
      private static const OUT_ANIMATION_START_FRAME:int = 50;
      
      private static const SWAP_ICONS_FRAME_OFFSET:int = 3;
       
      
      public var icon:UILoaderAlt = null;
      
      public var iconExtra:UILoaderAlt = null;
      
      public var iconRole:TankmenIcons = null;
      
      public var iconRank:TankmenIcons = null;
      
      public var bg:Sprite = null;
      
      public var roles:TileList = null;
      
      public var skills:SmallSkillsList = null;
      
      public var speed_xp_bg:UIComponent = null;
      
      public var newSkillAnim:MovieClip = null;
      
      public var levelSpecializationMain:CrewItemLabel = null;
      
      public var tankmenName:CrewItemLabel = null;
      
      public var rank:CrewItemLabel = null;
      
      public var role:CrewItemLabel = null;
      
      public var vehicleType:TextField = null;
      
      public var emptySlotBgAnim:MovieClip = null;
      
      public var emptySlotAnimMc:MovieClip = null;
      
      private var _index:uint = 0;
      
      private var _selectable:Boolean = true;
      
      public function CrewItemRenderer()
      {
         super();
         addFrameScript(OVER_ANIMATION_END_FRAME - SWAP_ICONS_FRAME_OFFSET,this.onOverAnimation);
         addFrameScript(OUT_ANIMATION_START_FRAME + SWAP_ICONS_FRAME_OFFSET,this.onOutAnimation);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         buttonMode = true;
         this.componentInspectorSetting = true;
         dropdown = DROPDOWN;
         itemRenderer = ITEM_RENDERER;
         menuPadding = new Padding(4,3,3,4);
         menuMargin = 0;
         this.newSkillAnim.visible = false;
         menuOffset.left = width - 1;
         this.inspectableThumbOffset = {
            "top":0,
            "bottom":0
         };
         this.bg.mouseEnabled = false;
         this.bg.mouseChildren = false;
         this.tankmenName.mouseEnabled = false;
         this.tankmenName.mouseChildren = false;
         this.icon.visible = true;
         this.iconExtra.visible = false;
      }
      
      override protected function showDropdown() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:Class = null;
         var _loc3_:Point = null;
         if(dropdown == null)
         {
            return;
         }
         if(dropdown is String && dropdown != EMPTY_STR)
         {
            _loc2_ = App.utils.classFactory.getClass(dropdown.toString());
            if(_loc2_ != null)
            {
               _loc1_ = App.utils.classFactory.getComponent(dropdown.toString(),CoreList);
            }
         }
         if(_loc1_)
         {
            if(itemRenderer is String && itemRenderer != EMPTY_STR)
            {
               _loc1_.itemRenderer = App.utils.classFactory.getClass(itemRenderer.toString());
            }
            else if(itemRenderer is Class)
            {
               _loc1_.itemRenderer = Class(itemRenderer);
            }
            if(scrollBar is String && scrollBar != EMPTY_STR)
            {
               _loc1_.scrollBar = App.utils.classFactory.getClass(scrollBar.toString());
            }
            else if(scrollBar is Class)
            {
               _loc1_.scrollBar = Class(scrollBar);
            }
            _loc1_.selectedIndex = Boolean(TankmanRoleVO(this.data).tankmanID) ? 1 : 0;
            _loc1_.width = menuWidth == -1 ? Number(width + menuOffset.left + menuOffset.right) : Number(menuWidth);
            _loc1_.dataProvider = _dataProvider;
            _loc1_.padding = menuPadding;
            _loc1_.wrapping = menuWrapping;
            _loc1_.margin = menuMargin;
            _loc1_.thumbOffset = {
               "top":thumbOffsetTop,
               "bottom":thumbOffsetBottom
            };
            _loc1_.focusTarget = this;
            _loc1_.rowCount = menuRowCount < 1 ? DEF_ROW_COUNT : menuRowCount;
            _loc1_.labelField = _labelField;
            _loc1_.labelFunction = _labelFunction;
            _loc1_.canCleanDataProvider = false;
            _dropdownRef = _loc1_;
            _dropdownRef.name = DROPDOWN_LIST_NAME;
            _dropdownRef.addEventListener(ListEvent.ITEM_CLICK,this.onDropDownItemClickHandler,false,0,true);
            _dropdownRef.addEventListener(TutorialEvent.VIEW_READY_FOR_TUTORIAL,this.onDropDownViewReadyForTutorialHandler);
            _loc3_ = new Point(x + menuOffset.left,menuDirection == DOWN_MENU_DIRECTION ? Number(y + height + menuOffset.top) : Number(y - _dropdownRef.height + menuOffset.bottom));
            _loc3_ = parent.localToGlobal(_loc3_);
            App.utils.popupMgr.show(_dropdownRef,_loc3_.x,_loc3_.y);
         }
         if(_dropdownRef)
         {
            dispatchEvent(new CrewDropDownEvent(CrewDropDownEvent.SHOW_DROP_DOWN,_dropdownRef));
         }
      }
      
      override protected function hideDropdown() : void
      {
         App.toolTipMgr.hide();
         if(_dropdownRef)
         {
            _dropdownRef.removeEventListener(ListEvent.ITEM_CLICK,this.onDropDownItemClickHandler,false);
            _dropdownRef.removeEventListener(TutorialEvent.VIEW_READY_FOR_TUTORIAL,this.onDropDownViewReadyForTutorialHandler);
            if(_dropdownRef is IDisposable)
            {
               IDisposable(_dropdownRef).dispose();
            }
            App.utils.commons.releaseReferences(_dropdownRef);
            _dropdownRef.parent.removeChild(_dropdownRef);
            _dropdownRef = null;
            dispatchEvent(new CrewDropDownEvent(CrewDropDownEvent.HIDE_DROP_DOWN,_dropdownRef));
         }
      }
      
      override protected function updateAfterStateChange() : void
      {
         var _loc1_:TankmanRoleVO = null;
         var _loc2_:TankmanVO = null;
         super.updateAfterStateChange();
         if(this.data)
         {
            _loc1_ = TankmanRoleVO(this.data);
            _loc2_ = _loc1_.tankman;
            if(_loc2_)
            {
               this.tankmenName.label = _loc2_.rank + SPACE_DELIMITER + _loc2_.fullName;
               if(_state == ComponentState.UP || _state == ComponentState.DISABLED || [ComponentState.OUT,ComponentState.TOGGLE,ComponentState.KB_RELEASE].indexOf(_state) > -1 && !selected)
               {
                  this.tankmenName.label = _loc2_.rank + SPACE_DELIMITER + _loc2_.lastName;
               }
            }
         }
      }
      
      override protected function draw() : void
      {
         if(isInvalid(InvalidationType.SELECTED_INDEX) || isInvalid(InvalidationType.DATA))
         {
            _dataProvider.requestItemAt(_selectedIndex,populateText);
            invalidateData();
            if(_dataProvider.length > 5)
            {
               menuPadding.right = 0;
               menuWidth = MENU_WIDTH + SCROLLBAR_PADDING + menuPadding.right + menuPadding.left;
            }
            else
            {
               menuPadding.right = 4;
               menuWidth = MENU_WIDTH + menuPadding.right + menuPadding.left;
            }
         }
         if(isInvalid(InvalidationType.STATE))
         {
            if(_newFrame)
            {
               gotoAndPlay(_newFrame);
               if(_baseDisposed)
               {
                  return;
               }
               _newFrame = null;
            }
            if(focusIndicator && _newFocusIndicatorFrame)
            {
               focusIndicator.gotoAndPlay(_newFocusIndicatorFrame);
               _newFocusIndicatorFrame = null;
            }
            this.updateAfterStateChange();
            dispatchEvent(new ComponentEvent(ComponentEvent.STATE_CHANGE));
            invalidate(InvalidationType.DATA,InvalidationType.SIZE);
         }
         if(isInvalid(InvalidationType.DATA))
         {
            updateText();
            if(autoSize != TextFieldAutoSize.NONE)
            {
               invalidateSize();
            }
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            if(!constraintsDisabled)
            {
               if(constraints)
               {
                  constraints.update(_width,_height);
               }
            }
         }
      }
      
      override protected function onDispose() : void
      {
         addFrameScript(OVER_ANIMATION_END_FRAME - SWAP_ICONS_FRAME_OFFSET,null);
         addFrameScript(OUT_ANIMATION_START_FRAME + SWAP_ICONS_FRAME_OFFSET,null);
         this.hideDropdown();
         if(scrollBar && scrollBar is IDisposable)
         {
            IDisposable(scrollBar).dispose();
         }
         scrollBar = null;
         this.icon.dispose();
         this.icon = null;
         this.iconExtra.dispose();
         this.iconExtra = null;
         this.iconRole.dispose();
         this.iconRole = null;
         this.iconRank.dispose();
         this.iconRank = null;
         this.bg = null;
         this.roles.dispose();
         this.roles = null;
         this.skills.dispose();
         this.skills = null;
         this.speed_xp_bg.dispose();
         this.speed_xp_bg = null;
         this.newSkillAnim = null;
         this.levelSpecializationMain.dispose();
         this.levelSpecializationMain = null;
         this.tankmenName.dispose();
         this.tankmenName = null;
         this.rank.dispose();
         this.rank = null;
         this.role.dispose();
         this.role = null;
         this.vehicleType = null;
         this.emptySlotBgAnim = null;
         this.emptySlotAnimMc = null;
         if(_data && _data is IDisposable)
         {
            IDisposable(_data).dispose();
            _data = null;
         }
         super.onDispose();
      }
      
      override protected function canLog() : Boolean
      {
         return false;
      }
      
      public function generatedUnstoppableEvents() : Boolean
      {
         return true;
      }
      
      public function getData() : Object
      {
         return this.data;
      }
      
      public function getTutorialDescriptionName() : String
      {
         return null;
      }
      
      public function needPreventInnerEvents() : Boolean
      {
         return true;
      }
      
      public function openPersonalCase(param1:uint = 0) : void
      {
         dispatchEvent(new CrewEvent(CrewEvent.OPEN_PERSONAL_CASE,this.data,false,param1));
      }
      
      public function setData(param1:Object) : void
      {
         close();
         this.data = param1;
         if(!param1)
         {
            this.visible = false;
            return;
         }
         var _loc2_:TankmanRoleVO = TankmanRoleVO(param1);
         if(dataProvider != null)
         {
            dataProvider.cleanUp();
         }
         this.dataProvider = new DataProvider(_loc2_.recruitList);
         var _loc3_:int = this.getTopPositionPadding();
         var _loc4_:Number = parent.parent.y - y - _height;
         menuOffset.top = Math.round(_loc3_ >= _loc4_ ? Number(_loc3_) : Number(_loc4_)) - 3;
         var _loc5_:TankmanVO = _loc2_.tankman;
         if(_loc5_.iconFile != this.icon.source && _loc5_.iconFile)
         {
            this.icon.source = TANKMEN_ICONS_SMALL + _loc5_.iconFile;
            this.iconExtra.source = this.icon.source;
         }
         if(_loc5_.rankIconFile != this.iconRank.imageLoader.source && _loc5_.rankIconFile)
         {
            this.iconRank.imageLoader.visible = true;
            this.iconRank.imageLoader.source = TANKMEN_RANKS_SMALL + _loc5_.rankIconFile;
         }
         else
         {
            this.iconRank.imageLoader.visible = false;
         }
         if(_loc5_.roleIconFile != this.iconRole.imageLoader.source && _loc5_.roleIconFile)
         {
            this.iconRole.imageLoader.visible = true;
            this.iconRole.imageLoader.source = _loc5_.roleIconFile;
         }
         var _loc6_:TankmanTextCreator = new TankmanTextCreator(_loc5_,_loc2_);
         this.role.label = _loc6_.roleHtml;
         this.levelSpecializationMain.label = _loc6_.levelSpecializationMainHtml;
         var _loc7_:Array = [];
         var _loc8_:int = _loc2_.roles.length;
         var _loc9_:int = 0;
         while(_loc9_ < _loc8_)
         {
            _loc7_.push(new SkillsVO({"icon":TANKMEN_ROLES_SMALL + _loc2_.roles[_loc9_] + IMAGE_EXTENSION}));
            _loc9_++;
         }
         if(this.roles.dataProvider != null)
         {
            this.roles.dataProvider.cleanUp();
         }
         this.roles.dataProvider = new DataProvider(_loc7_);
         this.speed_xp_bg.visible = _loc5_.isLessMastered;
         if(isNaN(_loc2_.tankmanID))
         {
            if(App.globalVarsMgr.isKoreaS())
            {
               this.emptySlotBgAnim.visible = true;
               this.emptySlotBgAnim.gotoAndPlay(1);
            }
            else
            {
               this.hideEmptySlotBgAnim();
            }
            if(_baseDisposed)
            {
               return;
            }
            this.emptySlotAnimMc.visible = true;
            this.emptySlotAnimMc.gotoAndPlay(2);
         }
         else
         {
            this.hideEmptySlotBgAnim();
            if(_baseDisposed)
            {
               return;
            }
            this.emptySlotAnimMc.visible = false;
            this.emptySlotAnimMc.gotoAndStop(1);
         }
         if(_baseDisposed)
         {
            return;
         }
         this.skills.updateSkills(_loc5_);
         this.newSkillAnim.visible = _loc5_.canBuySkill;
         selected = false;
         visible = true;
      }
      
      public function setListData(param1:ListData) : void
      {
         this.index = param1.index;
         selected = param1.selected;
         label = param1.label || EMPTY_LABEL;
      }
      
      protected function getTopPositionPadding() : int
      {
         var _loc1_:TankmanRoleVO = TankmanRoleVO(this.data);
         var _loc2_:Number = _height * (_loc1_.recruitList.length < menuRowCount ? _loc1_.recruitList.length : menuRowCount);
         return (_height - _loc2_ >> 1) - _height;
      }
      
      private function playSound(param1:String) : void
      {
         App.soundMgr.playControlsSnd(param1,SOUND_TYPE,SOUND_ID);
      }
      
      private function hideEmptySlotBgAnim() : void
      {
         this.emptySlotBgAnim.visible = false;
         this.emptySlotBgAnim.gotoAndStop(1);
      }
      
      override public function get data() : Object
      {
         return _data;
      }
      
      override public function set data(param1:Object) : void
      {
         _data = param1;
      }
      
      override public function set dataProvider(param1:IDataProvider) : void
      {
         dropdown = param1.length > 1 ? DROPDOWN : DROPDOWN2;
         menuRowCount = param1.length < DEF_ROW_COUNT ? Number(param1.length) : Number(DEF_ROW_COUNT);
         if(param1.length > this.menuRowCount)
         {
            super.scrollBar = Linkages.SCROLL_BAR;
         }
         else
         {
            super.scrollBar = null;
         }
         super.dataProvider = param1;
      }
      
      public function get index() : uint
      {
         return this._index;
      }
      
      public function set index(param1:uint) : void
      {
         this._index = param1;
      }
      
      public function get selectable() : Boolean
      {
         return this._selectable;
      }
      
      public function set selectable(param1:Boolean) : void
      {
         this._selectable = param1;
      }
      
      public function get hasData() : Boolean
      {
         return Boolean(!isNaN(TankmanRoleVO(this.data).tankmanID));
      }
      
      override protected function handleMouseRelease(param1:MouseEvent) : void
      {
         var _loc4_:TileList = null;
         var _loc5_:DataProvider = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:DisplayObject = null;
         var _loc9_:Number = NaN;
         var _loc2_:ICommons = App.utils.commons;
         var _loc3_:TankmanRoleVO = TankmanRoleVO(this.data);
         if(_loc2_.isLeftButton(param1))
         {
            _loc4_ = this.skills.skills;
            _loc5_ = DataProvider(_loc4_.dataProvider);
            if(_loc5_ != null)
            {
               _loc6_ = _loc5_.length;
               _loc7_ = 0;
               while(_loc7_ < _loc6_)
               {
                  if(_loc5_[_loc7_].buy)
                  {
                     _loc8_ = DisplayObject(_loc4_.getRendererAt(_loc7_));
                     _loc9_ = _loc8_.width;
                     if(_loc8_.mouseX > 0 && _loc8_.mouseX < _loc9_ && (_loc8_.mouseY > 0 && _loc8_.mouseY < _loc9_))
                     {
                        if(selected)
                        {
                           close();
                        }
                        if(_loc3_.tankmanID > 0)
                        {
                           this.openPersonalCase(SELECTED_TAB_INDEX);
                           setState(ComponentState.OUT);
                           return;
                        }
                     }
                  }
                  _loc7_++;
               }
            }
         }
         if(_loc2_.isRightButton(param1))
         {
            callLogEvent(param1);
            if(_loc3_.tankmanID > 0 && this.enabled)
            {
               App.contextMenuMgr.show(CONTEXT_MENU_HANDLER_TYPE.CREW,this,{"tankmanID":_loc3_.tankmanID});
               App.toolTipMgr.hide();
            }
         }
         super.handleMouseRelease(param1);
      }
      
      override protected function handleMouseRollOver(param1:MouseEvent) : void
      {
         super.handleMouseRollOver(param1);
         this.playSound(ComponentState.OVER);
      }
      
      override protected function handleMouseRollOut(param1:MouseEvent) : void
      {
         super.handleMouseRollOut(param1);
         this.playSound(ComponentState.OUT);
      }
      
      override protected function handleMousePress(param1:MouseEvent) : void
      {
         super.handleMousePress(param1);
         if(App.utils.commons.isLeftButton(param1) && enabled)
         {
            this.playSound(SoundManagerStates.SND_PRESS);
         }
      }
      
      override protected function dropdownRefReadyForTutorialHandler(param1:TutorialEvent) : void
      {
         param1.stopImmediatePropagation();
         dispatchEvent(param1);
      }
      
      private function onOverAnimation() : void
      {
         this.iconExtra.visible = true;
         this.icon.visible = false;
      }
      
      private function onOutAnimation() : void
      {
         this.icon.visible = true;
         this.iconExtra.visible = false;
      }
      
      private function onDropDownItemClickHandler(param1:ListEvent) : void
      {
         handleMenuItemClick(param1);
      }
      
      private function onDropDownViewReadyForTutorialHandler(param1:TutorialEvent) : void
      {
         this.dropdownRefReadyForTutorialHandler(param1);
      }
   }
}
