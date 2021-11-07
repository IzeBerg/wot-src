package net.wg.gui.rally.views.list
{
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.Errors;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.rally.events.RallyViewsEvent;
   import net.wg.gui.rally.interfaces.IRallyNoSortieScreen;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.exceptions.AbstractException;
   import net.wg.infrastructure.interfaces.IFocusChainContainer;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class AbtractRallyDetailsSection extends UIComponentEx implements IFocusChainContainer
   {
       
      
      public var noRallyScreen:IRallyNoSortieScreen = null;
      
      public var joinInfoTF:TextField = null;
      
      public var joinButton:ISoundButtonEx = null;
      
      private var _changedVisibilityList:Vector.<DisplayObject> = null;
      
      public function AbtractRallyDetailsSection()
      {
         super();
         this.noRallyScreen.update(FORTIFICATIONS.SORTIE_LISTVIEW_NOTSELECTED);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.setChangedVisibilityItems();
         this.noRallyScreen.visible = false;
         if(this.joinButton)
         {
            this.joinButton.addEventListener(ButtonEvent.CLICK,this.onJoinButtonClickHandler);
            this.joinButton.addEventListener(MouseEvent.ROLL_OVER,this.onJoinButtonRollOverHandler);
            this.joinButton.addEventListener(MouseEvent.ROLL_OUT,this.onJoinButtonRollOutHandler);
         }
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.updateElements();
         }
      }
      
      override protected function onDispose() : void
      {
         this._changedVisibilityList.splice(0,this._changedVisibilityList.length);
         this._changedVisibilityList = null;
         this.noRallyScreen.dispose();
         this.noRallyScreen = null;
         if(this.joinButton)
         {
            this.joinButton.removeEventListener(ButtonEvent.CLICK,this.onJoinButtonClickHandler);
            this.joinButton.removeEventListener(MouseEvent.ROLL_OVER,this.onJoinButtonRollOverHandler);
            this.joinButton.removeEventListener(MouseEvent.ROLL_OUT,this.onJoinButtonRollOutHandler);
            this.joinButton.dispose();
            this.joinButton = null;
         }
         this.joinInfoTF = null;
         super.onDispose();
      }
      
      public function getFocusChain() : Vector.<InteractiveObject>
      {
         return new Vector.<InteractiveObject>();
      }
      
      public function updateNoRallyScreenVisibility(param1:Boolean) : void
      {
         if(this.noRallyScreen.visible != param1)
         {
            this.noRallyScreen.visible = param1;
         }
      }
      
      protected function addItemsToChangedVisibilityList(... rest) : void
      {
         var _loc2_:DisplayObject = null;
         if(this._changedVisibilityList == null)
         {
            this._changedVisibilityList = new Vector.<DisplayObject>();
         }
         for each(_loc2_ in rest)
         {
            this._changedVisibilityList.push(_loc2_);
         }
      }
      
      protected function setChangedVisibilityItems() : void
      {
         this.addItemsToChangedVisibilityList(this.joinButton,this.joinInfoTF);
      }
      
      protected function isModelAvailable() : Boolean
      {
         return false;
      }
      
      protected function updateElements() : void
      {
         if(this.isModelAvailable())
         {
            this.updateNoRallyScreen(false);
         }
         else
         {
            this.updateNoRallyScreen(true);
         }
      }
      
      protected function updateNoRallyScreen(param1:Boolean) : void
      {
         this.updateNoRallyScreenVisibility(param1);
         this.updateElementsVisibility(!param1);
      }
      
      protected function updateElementsVisibility(param1:Boolean) : void
      {
         var _loc2_:DisplayObject = null;
         for each(_loc2_ in this._changedVisibilityList)
         {
            if(_loc2_)
            {
               _loc2_.visible = param1;
            }
         }
      }
      
      protected function onControlRollOver(param1:Object) : void
      {
         throw new AbstractException("AbtractRallyDetailsSection::onControlRollOver() " + Errors.ABSTRACT_INVOKE);
      }
      
      protected function onControlRollOut(param1:Object) : void
      {
         App.toolTipMgr.hide();
      }
      
      protected function onJoinButtonClick() : void
      {
         dispatchEvent(new RallyViewsEvent(RallyViewsEvent.JOIN_RALLY_REQUEST));
      }
      
      protected function onJoinButtonRollOverHandler(param1:MouseEvent) : void
      {
         this.onControlRollOver(param1.currentTarget);
      }
      
      protected function onJoinButtonRollOutHandler(param1:MouseEvent) : void
      {
         this.onControlRollOut(param1.currentTarget);
      }
      
      protected function onJoinButtonClickHandler(param1:ButtonEvent) : void
      {
         this.onJoinButtonClick();
      }
   }
}
