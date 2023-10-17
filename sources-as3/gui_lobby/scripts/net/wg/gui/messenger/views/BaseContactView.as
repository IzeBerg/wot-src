package net.wg.gui.messenger.views
{
   import flash.display.InteractiveObject;
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.gui.lobby.components.IResizableContent;
   import net.wg.gui.messenger.controls.ContactsBtnBar;
   import net.wg.gui.messenger.controls.ContactsWindowViewBG;
   import net.wg.gui.messenger.data.ContactsViewInitDataVO;
   import net.wg.gui.messenger.meta.IBaseContactViewMeta;
   import net.wg.gui.messenger.meta.impl.BaseContactViewMeta;
   import net.wg.infrastructure.interfaces.IFocusChainContainer;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class BaseContactView extends BaseContactViewMeta implements IBaseContactViewMeta, IResizableContent, IFocusChainContainer
   {
      
      public static const ON_CANCEL_CLICKED:String = "cancelClicked";
      
      private static const INIT_DATA_INV:String = "initInv";
       
      
      public var title:TextField = null;
      
      public var btns:ContactsBtnBar = null;
      
      public var background:ContactsWindowViewBG = null;
      
      private var _initData:ContactsViewInitDataVO = null;
      
      public function BaseContactView()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.btns.btnOk.addEventListener(ButtonEvent.CLICK,this.onBtnOkClickHandler,false,0,true);
         this.btns.btnCancel.addEventListener(ButtonEvent.CLICK,this.onBtnCancelClickHandler,false,0,true);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INIT_DATA_INV) && this._initData)
         {
            this.applyInitData(this._initData);
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.btns.width = _width;
            this.background.setSize(width,height);
            this.background.invalidate();
         }
      }
      
      override protected function onDispose() : void
      {
         this.btns.btnOk.removeEventListener(ButtonEvent.CLICK,this.onBtnOkClickHandler);
         this.btns.btnCancel.removeEventListener(ButtonEvent.CLICK,this.onBtnCancelClickHandler);
         this.btns.dispose();
         this.btns = null;
         this.background.dispose();
         this.background = null;
         this.title = null;
         this._initData = null;
         super.onDispose();
      }
      
      public function as_closeView() : void
      {
         dispatchEvent(new Event(ON_CANCEL_CLICKED,true));
      }
      
      override protected function setInitData(param1:ContactsViewInitDataVO) : void
      {
         this._initData = param1;
         invalidate(INIT_DATA_INV);
      }
      
      public function as_setOkBtnEnabled(param1:Boolean) : void
      {
         this.btns.btnOk.enabled = param1;
      }
      
      public function as_update(param1:Object) : void
      {
      }
      
      public function canShowAutomatically() : Boolean
      {
         return true;
      }
      
      public function getComponentForFocus() : InteractiveObject
      {
         return this.btns.btnOk;
      }
      
      public function getFocusChain() : Vector.<InteractiveObject>
      {
         return new <InteractiveObject>[this.btns.btnOk,this.btns.btnCancel];
      }
      
      public function setViewSize(param1:Number, param2:Number) : void
      {
         setSize(param1,param2);
         invalidate();
      }
      
      public function update(param1:Object) : void
      {
      }
      
      override protected function getContactsViewInitDataVOForData(param1:Object) : ContactsViewInitDataVO
      {
         return new ContactsViewInitDataVO(param1);
      }
      
      protected function applyInitData(param1:ContactsViewInitDataVO) : void
      {
         this.btns.btnOk.label = this._initData.btOkLbl;
         this.btns.btnCancel.label = this._initData.btnCancelLbl;
         this.btns.btnOk.tooltip = this._initData.btOkTooltip;
         this.btns.btnCancel.tooltip = this._initData.btnCancelTooltip;
         this.title.text = this._initData.mainLbl;
      }
      
      protected function onButtonClick() : void
      {
         onOkS(null);
      }
      
      public function get centerOffset() : int
      {
         return 0;
      }
      
      public function set centerOffset(param1:int) : void
      {
      }
      
      public function get active() : Boolean
      {
         return false;
      }
      
      public function set active(param1:Boolean) : void
      {
      }
      
      private function onBtnCancelClickHandler(param1:ButtonEvent) : void
      {
         onCancelS();
         dispatchEvent(new Event(ON_CANCEL_CLICKED,true));
      }
      
      private function onBtnOkClickHandler(param1:Event) : void
      {
         this.onButtonClick();
      }
   }
}
