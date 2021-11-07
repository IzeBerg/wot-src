package net.wg.gui.lobby.clans.profile.views
{
   import flash.display.InteractiveObject;
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.advanced.events.DummyEvent;
   import net.wg.gui.components.advanced.vo.DummyVO;
   import net.wg.gui.lobby.clans.common.ClanBaseInfoVO;
   import net.wg.gui.lobby.clans.common.IClanHeaderComponent;
   import net.wg.gui.lobby.clans.profile.ClanProfileEvent;
   import net.wg.gui.lobby.clans.profile.VOs.ClanProfileHeaderStateVO;
   import net.wg.infrastructure.base.meta.IClanProfileBaseViewMeta;
   import net.wg.infrastructure.base.meta.impl.ClanProfileBaseViewMeta;
   import net.wg.infrastructure.exceptions.AbstractException;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   
   public class ClanProfileBaseView extends ClanProfileBaseViewMeta implements IViewStackContent, IClanProfileBaseViewMeta
   {
       
      
      public var header:IClanHeaderComponent = null;
      
      private var _currentLinkage:String = "";
      
      private var _isShowWaiting:Boolean = true;
      
      private var _dummyData:DummyVO = null;
      
      public function ClanProfileBaseView()
      {
         super();
      }
      
      override protected function showDummy(param1:DummyVO) : void
      {
         var _loc2_:DummyEvent = new DummyEvent(DummyEvent.SHOW_DUMMY);
         this._dummyData = param1;
         _loc2_.data = param1;
         dispatchEvent(_loc2_);
      }
      
      override protected function onDispose() : void
      {
         this._dummyData = null;
         App.utils.scheduler.cancelTask(this.updateStateView);
         this.header.removeEventListener(ClanProfileEvent.HEADER_BUTTON_CLICK,this.onHeaderButtonClickHandler);
         this.header.dispose();
         this.header = null;
         super.onDispose();
      }
      
      override protected function setClanInfo(param1:ClanBaseInfoVO) : void
      {
         this.header.setBaseInfo(param1);
      }
      
      override protected function setHeaderState(param1:ClanProfileHeaderStateVO) : void
      {
         this.header.setState(param1);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.header.addEventListener(ClanProfileEvent.HEADER_BUTTON_CLICK,this.onHeaderButtonClickHandler);
      }
      
      public function as_hideDummy() : void
      {
         this._dummyData = null;
         dispatchEvent(new DummyEvent(DummyEvent.HIDE_DUMMY));
      }
      
      public function as_setClanEmblem(param1:String) : void
      {
         this.header.setEmblem(param1);
      }
      
      public function as_setData(param1:Object) : void
      {
         throw new AbstractException("ClanProfileBaseView.as_setData" + Errors.ABSTRACT_INVOKE);
      }
      
      public function as_showWaiting(param1:Boolean) : void
      {
         this._isShowWaiting = param1;
         App.utils.scheduler.scheduleOnNextFrame(this.updateStateView,param1);
      }
      
      public function as_loadBrowser() : void
      {
         throw new AbstractException("ClanProfileBaseView.as_loadBrowser" + Errors.ABSTRACT_INVOKE);
      }
      
      public function canShowAutomatically() : Boolean
      {
         return false;
      }
      
      public function getComponentForFocus() : InteractiveObject
      {
         return this;
      }
      
      public function getDummyData() : DummyVO
      {
         return this._dummyData;
      }
      
      public function isShowWaiting() : Boolean
      {
         return this._isShowWaiting;
      }
      
      public function update(param1:Object) : void
      {
      }
      
      private function updateStateView(param1:Boolean) : void
      {
         var _loc2_:String = !!param1 ? ClanProfileEvent.SHOW_WAITING : ClanProfileEvent.HIDE_WAITING;
         dispatchEvent(new ClanProfileEvent(_loc2_,null,this._currentLinkage));
      }
      
      override public function set visible(param1:Boolean) : void
      {
         super.visible = param1;
         if(this.header)
         {
            this.header.updateFilters(param1);
         }
      }
      
      public function get currentLinkage() : String
      {
         return this._currentLinkage;
      }
      
      public function set currentLinkage(param1:String) : void
      {
         this._currentLinkage = param1;
      }
      
      private function onHeaderButtonClickHandler(param1:ClanProfileEvent) : void
      {
         onHeaderButtonClickS(param1.getActionID());
      }
   }
}
