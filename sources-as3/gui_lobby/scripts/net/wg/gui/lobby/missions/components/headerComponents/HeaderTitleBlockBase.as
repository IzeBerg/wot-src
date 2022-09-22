package net.wg.gui.lobby.missions.components.headerComponents
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.SoundManagerStates;
   import net.wg.data.constants.SoundTypes;
   import net.wg.gui.components.assets.data.SeparatorConstants;
   import net.wg.gui.components.assets.interfaces.ISeparatorAsset;
   import net.wg.gui.lobby.missions.data.HeaderTitleBlockBaseVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.ISoundable;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import scaleform.clik.constants.InvalidationType;
   
   public class HeaderTitleBlockBase extends UIComponentEx implements IUpdatable, ISoundable
   {
      
      private static const TITLE_LIGHT_BACK_ALPHA_NORMAL:Number = 0.8;
      
      private static const TITLE_LIGHT_BACK_ALPHA_SELECTED:Number = 1;
       
      
      public var title:TextField;
      
      public var titleLightBack:Sprite;
      
      public var separator:ISeparatorAsset;
      
      public var hit:Sprite;
      
      public var cornerRight:Sprite;
      
      private var _data:HeaderTitleBlockBaseVO;
      
      private var _isSelectedState:Boolean = false;
      
      private var _soundType:String = "tab";
      
      private var _soundId:String = "";
      
      private var _soundEnabled:Boolean = true;
      
      public function HeaderTitleBlockBase()
      {
         super();
      }
      
      public function canPlaySound(param1:String) : Boolean
      {
         return this.enabled;
      }
      
      public final function getSoundType() : String
      {
         return this._soundType;
      }
      
      public final function getSoundId() : String
      {
         return this._soundId;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mouseChildren = false;
         this.title.mouseEnabled = false;
         this.titleLightBack.mouseEnabled = false;
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         hitArea = this.hit;
         this.separator.setType(SeparatorConstants.MEDIUM_TYPE);
         this.setSelectedState();
         if(App.soundMgr != null && this._soundEnabled)
         {
            App.soundMgr.addSoundsHdlrs(this);
         }
      }
      
      private function onMouseOut(param1:MouseEvent) : void
      {
         App.soundMgr.playControlsSnd(SoundManagerStates.SND_OVER,SoundTypes.TAB,this._soundId);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.setTitle();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.hit.width = width;
            this.titleLightBack.x = width - this.titleLightBack.width >> 1;
            this.separator.width = width - this.separator.x | 0;
            this.cornerRight.x = width - this.cornerRight.width | 0;
         }
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         this.separator.dispose();
         this.separator = null;
         this.title = null;
         this.titleLightBack = null;
         this.hit = null;
         this.cornerRight = null;
         this._data = null;
         super.onDispose();
      }
      
      override protected function onBeforeDispose() : void
      {
         if(App.soundMgr != null)
         {
            App.soundMgr.removeSoundHdlrs(this);
         }
         super.onBeforeDispose();
      }
      
      public function setCollapsed(param1:Boolean, param2:Boolean) : void
      {
      }
      
      public function update(param1:Object) : void
      {
         this._data = HeaderTitleBlockBaseVO(param1);
         invalidateData();
      }
      
      protected function setTitle() : void
      {
         this.title.htmlText = this._data.title;
      }
      
      private function setSelectedState() : void
      {
         this.titleLightBack.alpha = !!this._isSelectedState ? Number(TITLE_LIGHT_BACK_ALPHA_SELECTED) : Number(TITLE_LIGHT_BACK_ALPHA_NORMAL);
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         this._isSelectedState = true;
         this.setSelectedState();
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         this._isSelectedState = false;
         this.setSelectedState();
      }
   }
}
