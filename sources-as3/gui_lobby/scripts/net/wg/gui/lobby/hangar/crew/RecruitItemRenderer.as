package net.wg.gui.lobby.hangar.crew
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import net.wg.data.constants.ComponentState;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import net.wg.gui.components.controls.TileList;
   import net.wg.gui.events.CrewEvent;
   import net.wg.gui.lobby.components.SmallSkillsList;
   import net.wg.gui.lobby.components.data.RoleVO;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.constants.NavigationCode;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.data.ListData;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.ui.InputDetails;
   
   public class RecruitItemRenderer extends SoundListItemRenderer
   {
      
      private static const TANKMEN_ICON_SMALL:String = "../maps/icons/tankmen/icons/small/";
      
      private static const TANKMEN_RANKS_SMALL:String = "../maps/icons/tankmen/ranks/small/";
      
      private static const TANKMEN_ROLES_SMALL:String = "../maps/icons/tankmen/roles/small/";
      
      private static const IMAGE_EXTENSION:String = ".png";
      
      private static const SOUND_TYPE:String = "rendererRecruit";
      
      private static const RECRUIT_PREFIX:String = "recruit_";
      
      private static const PERSONAL_CASE_PREFIX:String = "personalCase_";
       
      
      public var icon:TankmenIcons = null;
      
      public var iconRank:TankmenIcons = null;
      
      public var skills:SmallSkillsList = null;
      
      public var roles:TileList = null;
      
      public var sixthSenseIcon:Sprite = null;
      
      public var bg:MovieClip = null;
      
      public var focusIndicatorUI:MovieClip = null;
      
      public var levelSpecializationMain:TextField = null;
      
      public var nameTF:TextField = null;
      
      public var rank:TextField = null;
      
      public var role:TextField = null;
      
      public var vehicleType:TextField = null;
      
      private var _recruit:Boolean = false;
      
      private var _personalCase:Boolean = false;
      
      private var _textObj:TankmanTextCreator = null;
      
      private var _recruitData:TankmanVO = null;
      
      public function RecruitItemRenderer()
      {
         super();
         soundType = SOUND_TYPE;
      }
      
      override public function getData() : Object
      {
         return this._recruitData;
      }
      
      override public function setData(param1:Object) : void
      {
         if(this._recruitData == param1)
         {
            return;
         }
         this._recruitData = TankmanVO(param1);
         this.recruit = this._recruitData.recruit;
         this.personalCase = this._recruitData.personalCase;
         var _loc2_:Boolean = !this._recruitData.personalCase && !this._recruitData.recruit;
         this.icon.visible = this.iconRank.visible = _loc2_;
         if(_loc2_)
         {
            if(this._recruitData.iconFile != this.icon.imageLoader.source && this._recruitData.iconFile)
            {
               this.icon.imageLoader.visible = true;
               this.icon.imageLoader.source = TANKMEN_ICON_SMALL + this._recruitData.iconFile;
            }
            if(this._recruitData.rankIconFile != this.iconRank.imageLoader.source && this._recruitData.rankIconFile)
            {
               this.iconRank.imageLoader.visible = true;
               this.iconRank.imageLoader.source = TANKMEN_RANKS_SMALL + this._recruitData.rankIconFile;
            }
         }
         this.sixthSenseIcon.visible = this._recruitData.hasCommanderFeature && _loc2_;
         var _loc3_:Array = [];
         var _loc4_:int = this._recruitData.roles.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_.push(new RoleVO({
               "index":_loc5_,
               "icon":TANKMEN_ROLES_SMALL + this._recruitData.roles[_loc5_] + IMAGE_EXTENSION
            }));
            _loc5_++;
         }
         if(this.roles.dataProvider != null)
         {
            this.roles.dataProvider.cleanUp();
         }
         this.roles.dataProvider = new DataProvider(_loc3_);
         if(this.skills != null)
         {
            this.skills.updateSkills(this._recruitData);
         }
         this._textObj = new TankmanTextCreator(this._recruitData,this._recruitData.currentRole);
         setState(ComponentState.UP);
         var _loc6_:Point = new Point(mouseX,mouseY);
         _loc6_ = this.localToGlobal(_loc6_);
         if(this.hitTestPoint(_loc6_.x,_loc6_.y,true))
         {
            this.checkToolTipData(this._recruitData);
         }
      }
      
      override public function setListData(param1:ListData) : void
      {
         index = param1.index;
         selected = param1.selected;
         setState(ComponentState.UP);
      }
      
      override public function toString() : String
      {
         return "[Scaleform RecruitItemRenderer " + name + "]";
      }
      
      override protected function configUI() : void
      {
         this.visible = false;
         addEventListener(MouseEvent.CLICK,this.onClickHandler);
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDownHandler);
         this.focusIndicator = this.focusIndicatorUI;
         super.configUI();
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.CLICK,this.onClickHandler);
         removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDownHandler);
         this.icon.dispose();
         this.icon = null;
         this.iconRank.dispose();
         this.iconRank = null;
         this.skills.dispose();
         this.skills = null;
         this.roles.dispose();
         this.roles = null;
         this.sixthSenseIcon = null;
         this.bg = null;
         this.levelSpecializationMain = null;
         this.nameTF = null;
         this.rank = null;
         this.role = null;
         this.vehicleType = null;
         this.focusIndicatorUI = null;
         this._textObj = null;
         this._recruitData = null;
         focusIndicator = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Point = null;
         super.draw();
         this.skills.visible = this.roles.visible = true;
         if(this._recruit)
         {
            this.role.text = MENU.tankmanrecruitrenderer(this._recruitData.roleType);
            this.rank.text = MENU.TANKMANRECRUITRENDERER_DESCR;
            this.skills.visible = this.roles.visible = false;
         }
         if(this._personalCase)
         {
            this.role.text = MENU.TANKMANRECRUITRENDERER_PERSONALCASE;
            this.skills.visible = this.roles.visible = false;
         }
         if(this.nameTF && this.rank && this.role && this.levelSpecializationMain)
         {
            if(this._textObj != null)
            {
               this.nameTF.text = this._textObj.nameTF;
               this.rank.text = this._textObj.rank;
               this.role.htmlText = this._textObj.roleHtml;
               this.levelSpecializationMain.htmlText = this._textObj.levelSpecializationMainHtml;
            }
         }
         this.visible = true;
         if(this._recruitData && isInvalid(InvalidationType.DATA))
         {
            _loc1_ = new Point(mouseX,mouseY);
            _loc1_ = this.localToGlobal(_loc1_);
            if(this.hitTestPoint(_loc1_.x,_loc1_.y,true))
            {
               this.checkToolTipData(this._recruitData);
            }
         }
      }
      
      override protected function getStatePrefixes() : Vector.<String>
      {
         if(this._recruit)
         {
            return Vector.<String>([RECRUIT_PREFIX]);
         }
         if(this._personalCase)
         {
            return Vector.<String>([PERSONAL_CASE_PREFIX]);
         }
         return !!_selected ? statesSelected : statesDefault;
      }
      
      private function checkClick() : void
      {
         if(this._personalCase == true)
         {
            dispatchEvent(new CrewEvent(CrewEvent.OPEN_PERSONAL_CASE,this._recruitData.currentRole));
         }
         else if(this._recruit == true)
         {
            dispatchEvent(new CrewEvent(CrewEvent.SHOW_RECRUIT_WINDOW,this._recruitData));
         }
         else if(this._recruitData.tankmanID != this._recruitData.currentRole.tankmanID)
         {
            dispatchEvent(new CrewEvent(CrewEvent.EQUIP_TANKMAN,this._recruitData));
         }
      }
      
      private function checkToolTipData(param1:TankmanVO) : void
      {
         if(owner.visible)
         {
            if(!param1.recruit && !param1.personalCase)
            {
               App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.TANKMAN,null,param1.tankmanID,true);
            }
            else
            {
               this.hideTooltip();
            }
         }
      }
      
      private function hideTooltip() : void
      {
         App.toolTipMgr.hide();
      }
      
      public function set recruit(param1:Boolean) : void
      {
         this._recruit = param1;
         setState(ComponentState.UP);
      }
      
      public function set personalCase(param1:Boolean) : void
      {
         this._personalCase = param1;
         setState(ComponentState.UP);
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
         if(param1.isDefaultPrevented())
         {
            return;
         }
         var _loc2_:InputDetails = param1.details;
         var _loc3_:uint = _loc2_.controllerIndex;
         switch(_loc2_.navEquivalent)
         {
            case NavigationCode.ENTER:
               if(_loc2_.value == InputValue.KEY_DOWN)
               {
                  handlePress(_loc3_);
                  callLogEvent(param1);
                  param1.handled = true;
               }
               else if(_loc2_.value == InputValue.KEY_UP)
               {
                  if(_pressedByKeyboard)
                  {
                     handleRelease(_loc3_);
                     param1.handled = true;
                  }
               }
         }
      }
      
      private function onClickHandler(param1:MouseEvent) : void
      {
         this.hideTooltip();
         if(App.utils.commons.isLeftButton(param1))
         {
            this.checkClick();
         }
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         this.checkToolTipData(this._recruitData);
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         this.hideTooltip();
      }
      
      private function onMouseDownHandler(param1:MouseEvent) : void
      {
         this.hideTooltip();
      }
   }
}
