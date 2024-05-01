package net.wg.gui.cyberSport
{
   import flash.display.InteractiveObject;
   import flash.ui.Keyboard;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.generated.CYBER_SPORT_ALIASES;
   import net.wg.gui.components.windows.Window;
   import net.wg.gui.cyberSport.views.IntroView;
   import net.wg.gui.cyberSport.views.UnitView;
   import net.wg.gui.cyberSport.views.UnitsListView;
   import net.wg.gui.cyberSport.views.events.CSShowHelpEvent;
   import net.wg.infrastructure.base.meta.ICyberSportMainWindowMeta;
   import net.wg.infrastructure.base.meta.impl.CyberSportMainWindowMeta;
   import net.wg.infrastructure.events.FocusChainChangeEvent;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.ui.InputDetails;
   
   public class CyberSportMainWindow extends CyberSportMainWindowMeta implements ICyberSportMainWindowMeta
   {
      
      private static const FOCUS_CHAIN:String = "focusChain";
       
      
      private var _focusChain:Vector.<InteractiveObject>;
      
      public function CyberSportMainWindow()
      {
         this._focusChain = new Vector.<InteractiveObject>();
         super();
         showWindowBgForm = true;
         canMinimize = true;
         visible = true;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(FOCUS_CHAIN))
         {
            this.clearFocusChain();
            if(autoSearch)
            {
               this._focusChain = autoSearch.getFocusChain();
               if(this._focusChain.length > 0)
               {
                  this._focusChain.push(Window(window).minimizeBtn);
               }
               App.utils.commons.initTabIndex(this._focusChain);
            }
         }
      }
      
      override protected function configUI() : void
      {
         addEventListener(CSShowHelpEvent.SHOW_HELP,this.onShowHelpHandler);
         addEventListener(FocusChainChangeEvent.FOCUS_CHAIN_CHANGE,this.onFocusChainChangeHandler);
         super.configUI();
      }
      
      override protected function getWindowTitle() : String
      {
         return CYBERSPORT.WINDOW_TITLE;
      }
      
      override protected function updateFocus() : void
      {
         var _loc1_:UnitsListView = null;
         var _loc2_:InteractiveObject = null;
         var _loc3_:IntroView = null;
         if(autoSearch.visible)
         {
            autoSearchUpdateFocus();
         }
         else if(getCurrentView() is UnitsListView)
         {
            _loc1_ = getCurrentView() as UnitsListView;
            assertNotNull(_loc1_,Errors.CANT_NULL);
            _loc2_ = _loc1_.createBtn as InteractiveObject;
            assertNotNull(_loc2_,Errors.CANT_NULL);
            setFocus(_loc2_);
         }
         else if(getCurrentView() is IntroView)
         {
            _loc3_ = getCurrentView() as IntroView;
            assertNotNull(_loc3_,Errors.CANT_NULL);
            setFocus(_loc3_.autoMatchBtn);
         }
         else
         {
            super.updateFocus();
         }
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(CSShowHelpEvent.SHOW_HELP,this.onShowHelpHandler);
         removeEventListener(FocusChainChangeEvent.FOCUS_CHAIN_CHANGE,this.onFocusChainChangeHandler);
         this.clearFocusChain();
         this._focusChain = null;
         super.onDispose();
      }
      
      override protected function onViewLoadRequest(param1:*) : void
      {
         super.onViewLoadRequest(param1);
         if(!param1)
         {
            return;
         }
         switch(param1.alias)
         {
            case CYBER_SPORT_ALIASES.UNITS_LIST_VIEW_UI:
               onBrowseRalliesS();
               break;
            case CYBER_SPORT_ALIASES.UNIT_VIEW_UI:
               if(param1.itemId)
               {
                  onJoinRallyS(param1.itemId,param1.slotIndex,param1.peripheryID);
               }
               else
               {
                  onCreateRallyS();
               }
         }
      }
      
      override protected function hideAutoSearch() : void
      {
         super.hideAutoSearch();
         invalidate(FOCUS_CHAIN);
      }
      
      private function clearFocusChain() : void
      {
         var _loc1_:int = this._focusChain.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            this._focusChain[_loc2_].tabIndex = -1;
            _loc2_++;
         }
         this._focusChain.splice(0,this._focusChain.length);
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
         if(param1.handled)
         {
            return;
         }
         var _loc2_:InputDetails = param1.details;
         if(_loc2_.code == Keyboard.ESCAPE && _loc2_.value == InputValue.KEY_DOWN)
         {
            if(autoSearch.visible)
            {
               autoSearch.handleInput(param1);
            }
            else if(canGoBackS())
            {
               param1.handled = true;
               if(getCurrentView() is UnitView && UnitView(getCurrentView()).rosterTeamContext)
               {
                  UnitView(getCurrentView()).preInitFadeAnimationCancel();
               }
               else
               {
                  App.contextMenuMgr.hide();
                  onBackClickS();
               }
            }
            else if(window.getCloseBtn().enabled)
            {
               param1.handled = true;
               onWindowCloseS();
            }
         }
      }
      
      private function onFocusChainChangeHandler(param1:FocusChainChangeEvent) : void
      {
         invalidate(FOCUS_CHAIN);
      }
      
      private function onShowHelpHandler(param1:CSShowHelpEvent) : void
      {
         showHelpS(param1.helpId);
      }
   }
}
