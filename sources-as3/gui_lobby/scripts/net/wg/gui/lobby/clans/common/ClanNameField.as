package net.wg.gui.lobby.clans.common
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.Image;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.utils.ICommons;
   import scaleform.clik.constants.ConstrainMode;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.utils.Constraints;
   
   public class ClanNameField extends UIComponentEx implements IClanNameField
   {
      
      private static const INV_ICON_VISIBLE:String = "InvIconVisible";
      
      private static const INV_ICON_SOURCE:String = "InvIconSource";
      
      private static const ICON_SHIFT:int = 8;
      
      private static const ICON_Y:int = 9;
       
      
      public var textField:TextField = null;
      
      public var bg:DisplayObject = null;
      
      public var bounds:Sprite = null;
      
      private var _icon:Image = null;
      
      private var _clanVO:ClanVO = null;
      
      private var _canShowBg:Boolean = true;
      
      private var _showIcon:Boolean = false;
      
      private var _commons:ICommons = null;
      
      public function ClanNameField()
      {
         super();
         this.bg.visible = false;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._commons = App.utils.commons;
         constraints.addElement(this.textField.name,this.textField,Constraints.LEFT | Constraints.RIGHT | Constraints.CENTER_V);
         constraints.addElement(this.bounds.name,this.bounds,Constraints.ALL);
         initSize();
         this.textField.autoSize = TextFieldAutoSize.NONE;
      }
      
      override protected function preInitialize() : void
      {
         constraints = new Constraints(this,ConstrainMode.REFLOW);
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            constraints.update(_width,_height);
            this.updateTextFieldData();
         }
         if(isInvalid(InvalidationType.DATA))
         {
            _loc1_ = this._clanVO != null;
            this.textField.visible = _loc1_;
            this.updateTextFieldData();
         }
         if(isInvalid(InvalidationType.STATE))
         {
            this.bg.visible = this._canShowBg && this._clanVO && this._clanVO.isActive;
         }
         if(isInvalid(INV_ICON_VISIBLE))
         {
            this.updateIconVisible();
         }
         if(isInvalid(INV_ICON_SOURCE))
         {
            this.updateIconSource();
         }
      }
      
      override protected function onDispose() : void
      {
         this.bounds = null;
         if(this._icon)
         {
            removeChild(this._icon);
            this._icon.dispose();
            this._icon = null;
         }
         this.textField = null;
         this.bg = null;
         this._clanVO = null;
         this._commons = null;
         super.onDispose();
      }
      
      private function updateTextFieldData() : void
      {
         if(this._clanVO)
         {
            this._commons.truncateTextFieldText(this.textField,this._clanVO.fullName);
         }
      }
      
      private function updateIconSource() : void
      {
         if(this._icon)
         {
            if(this._clanVO)
            {
               this._icon.source = this._clanVO.iconSource;
            }
            else
            {
               this._icon.source = "";
            }
         }
      }
      
      private function updateIconVisible() : void
      {
         if(this._clanVO && this._clanVO.showIcon)
         {
            if(this._icon == null)
            {
               this.createIcon();
            }
            this.setIconVisible(true);
         }
         else if(this._icon)
         {
            this.setIconVisible(false);
         }
      }
      
      private function updateLayout() : void
      {
         if(this._icon.visible)
         {
            this.textField.x += ICON_SHIFT;
            this.bg.x += ICON_SHIFT;
            this.textField.width -= ICON_SHIFT;
         }
         else
         {
            this.bg.x -= ICON_SHIFT;
            this.textField.x -= ICON_SHIFT;
            this.textField.width += ICON_SHIFT;
         }
         this.updateTextFieldData();
      }
      
      private function createIcon() : void
      {
         this._icon = new Image();
         this._icon.y = ICON_Y;
         addChild(this._icon);
      }
      
      private function setIconVisible(param1:Boolean) : void
      {
         if(this._showIcon == param1)
         {
            return;
         }
         this._showIcon = param1;
         this._icon.visible = param1;
         this.updateLayout();
         invalidate(INV_ICON_SOURCE);
      }
      
      override public function set useHandCursor(param1:Boolean) : void
      {
         super.useHandCursor = param1;
         this.bounds.useHandCursor = param1;
      }
      
      override public function set buttonMode(param1:Boolean) : void
      {
         super.buttonMode = param1;
         this.bounds.buttonMode = param1;
      }
      
      public function get clanVO() : ClanVO
      {
         return this._clanVO;
      }
      
      public function set clanVO(param1:ClanVO) : void
      {
         this._clanVO = param1;
         invalidateData();
         invalidateState();
         invalidate(INV_ICON_VISIBLE,INV_ICON_SOURCE);
      }
      
      public function get canShowBg() : Boolean
      {
         return this._canShowBg;
      }
      
      public function set canShowBg(param1:Boolean) : void
      {
         this._canShowBg = param1;
         invalidateState();
      }
   }
}
