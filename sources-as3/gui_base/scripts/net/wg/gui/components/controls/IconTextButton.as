package net.wg.gui.components.controls
{
   import net.wg.data.constants.SoundTypes;
   import net.wg.utils.helpLayout.HelpLayoutVO;
   import scaleform.clik.core.UIComponent;
   
   public class IconTextButton extends IconButton
   {
      
      private static const ICO_TEXT_PADDING:Number = 5;
       
      
      public var alertMC:UIComponent;
      
      private var _caps:Boolean = true;
      
      private var _helpLayoutId:String = "";
      
      public function IconTextButton()
      {
         super();
         soundType = SoundTypes.ICON_TXT_BTN;
      }
      
      override public function getLayoutProperties() : Vector.<HelpLayoutVO>
      {
         if(!this._helpLayoutId)
         {
            this._helpLayoutId = name + "_" + Math.random();
         }
         var _loc1_:int = -3;
         var _loc2_:int = -2;
         var _loc3_:HelpLayoutVO = new HelpLayoutVO();
         _loc3_.x = 0;
         _loc3_.y = 0;
         _loc3_.width = width + _loc1_;
         _loc3_.height = height + _loc2_;
         _loc3_.extensibilityDirection = _helpDirection;
         _loc3_.message = _helpText;
         _loc3_.id = this._helpLayoutId;
         _loc3_.scope = this;
         return new <HelpLayoutVO>[_loc3_];
      }
      
      override protected function configIcon() : void
      {
         if(loader)
         {
            loader.x = _iconOffsetLeft;
            loader.y = _iconOffsetTop;
            loader.tabEnabled = loader.mouseEnabled = false;
            loader.visible = true;
         }
      }
      
      override protected function onDispose() : void
      {
         this.alertMC.dispose();
         this.alertMC = null;
         super.onDispose();
      }
      
      override protected function updateText() : void
      {
         var _loc1_:String = null;
         if(this.caps)
         {
            if(_label != null)
            {
               _loc1_ = App.utils.locale.makeString(_label,{});
               if(_loc1_)
               {
                  _loc1_ = App.utils.toUpperOrLowerCase(_loc1_,true);
               }
               else
               {
                  _loc1_ = "";
               }
               if(textField != null)
               {
                  textField.text = _loc1_;
               }
               if(textField1 != null)
               {
                  textField1.text = _loc1_;
               }
               if(blurTextField != null)
               {
                  blurTextField.text = _loc1_;
               }
               if(filtersMC != null && filtersMC.textField != null)
               {
                  filtersMC.textField.text = _loc1_;
               }
            }
         }
         else
         {
            super.updateText();
            if(blurTextField != null)
            {
               blurTextField.text = _label;
            }
            if(filtersMC != null && filtersMC.textField != null)
            {
               filtersMC.textField.text = _label;
            }
         }
      }
      
      public function set icon(param1:String) : void
      {
         RES_ICONS.maps_icons_buttons(param1);
         var _loc2_:String = RES_ICONS.MAPS_ICONS_BUTTONS + "/" + param1;
         if(iconSource != _loc2_)
         {
            iconSource = _loc2_;
         }
      }
      
      [Inspectable(defaultValue="true",name="caps",type="Boolean")]
      public function get caps() : Boolean
      {
         return this._caps;
      }
      
      public function set caps(param1:Boolean) : void
      {
         if(this._caps == param1)
         {
            return;
         }
         this._caps = param1;
         invalidate();
      }
   }
}
