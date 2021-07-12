package net.wg.gui.messenger.controls
{
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.containers.HorizontalGroupLayout;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.messenger.data.ContactItemVO;
   import net.wg.gui.messenger.data.ContactUserPropVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IUserProps;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import scaleform.clik.constants.InvalidationType;
   
   public class ContactItem extends UIComponentEx implements IUpdatable
   {
      
      private static const LAYOUT_INV:String = "layoutInv";
      
      private static const GROUP_PADDING_Y:int = 6;
       
      
      public var status:Image = null;
      
      public var textField:TextField = null;
      
      private var _data:ContactItemVO = null;
      
      private var _group:ContactAttributesGroup = null;
      
      private var _isExternalDataVO:Boolean = false;
      
      private var _isDataChange:Boolean = false;
      
      public function ContactItem()
      {
         super();
      }
      
      override protected function draw() : void
      {
         var _loc1_:ContactUserPropVO = null;
         var _loc2_:Vector.<String> = null;
         super.draw();
         if(this._data)
         {
            if(this._isDataChange && isInvalid(InvalidationType.DATA,InvalidationType.SIZE,InvalidationType.STATE))
            {
               this.status.source = this._data.resource;
               _loc1_ = this._data.userPropsVO;
               _loc2_ = _loc1_.icons;
               if(this._group == null && _loc2_.length > 0)
               {
                  this._group = new ContactAttributesGroup();
                  this._group.addEventListener(Event.RESIZE,this.onGroupResizeHandler,false,0,true);
                  this._group.layout = new HorizontalGroupLayout();
                  this._group.y = GROUP_PADDING_Y;
                  addChild(this._group);
                  this._group.validateNow();
               }
               if(this._group != null)
               {
                  this._group.setDataProvider(_loc2_);
               }
               invalidate(LAYOUT_INV);
               this._isDataChange = false;
            }
            if(isInvalid(LAYOUT_INV))
            {
               this.applyLayout();
            }
         }
      }
      
      override protected function onDispose() : void
      {
         if(this._group)
         {
            removeChild(this._group);
            this._group.removeEventListener(Event.RESIZE,this.onGroupResizeHandler);
            this._group.dispose();
            this._group = null;
         }
         this.textField = null;
         this.status.dispose();
         this.status = null;
         this.disposeInternalData();
         this._data = null;
         super.onDispose();
      }
      
      public function applyLayout() : void
      {
         var _loc1_:ContactUserPropVO = this._data.userPropsVO;
         var _loc2_:IUserProps = App.utils.commons.getUserProps(_loc1_.userName,_loc1_.clanAbbrev,_loc1_.region,0,[]);
         _loc2_.rgb = _loc1_.rgb;
         this.textField.autoSize = TextFieldAutoSize.NONE;
         this.textField.width = _width - this.textField.x - (Boolean(this._group) ? this._group.width : 0);
         App.utils.commons.formatPlayerName(this.textField,_loc2_);
         this.textField.autoSize = TextFieldAutoSize.LEFT;
         if(this._group)
         {
            this._group.x = int(this.textField.x + this.textField.width);
         }
      }
      
      public function update(param1:Object) : void
      {
         this.disposeInternalData();
         this._isExternalDataVO = param1 is ContactItemVO;
         this.data = !!this._isExternalDataVO ? ContactItemVO(param1) : new ContactItemVO(param1);
      }
      
      private function disposeInternalData() : void
      {
         if(this._data != null && !this._isExternalDataVO)
         {
            this._data.dispose();
         }
      }
      
      public function get data() : ContactItemVO
      {
         return this._data;
      }
      
      public function set data(param1:ContactItemVO) : void
      {
         if(param1 != this._data)
         {
            this._data = param1;
            this._isDataChange = true;
            invalidate(InvalidationType.DATA);
         }
      }
      
      private function onGroupResizeHandler(param1:Event) : void
      {
         if(param1.target == this._group)
         {
            param1.stopImmediatePropagation();
         }
         this.applyLayout();
      }
   }
}
