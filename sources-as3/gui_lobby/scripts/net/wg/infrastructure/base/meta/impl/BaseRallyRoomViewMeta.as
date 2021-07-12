package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.rally.BaseRallyView;
   import net.wg.gui.rally.data.TooltipDataVO;
   import net.wg.gui.rally.interfaces.IRallyVO;
   import net.wg.gui.rally.vo.ActionButtonVO;
   import net.wg.gui.rally.vo.VehicleVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class BaseRallyRoomViewMeta extends BaseRallyView
   {
       
      
      public var assignSlotRequest:Function;
      
      public var leaveSlotRequest:Function;
      
      public var onSlotsHighlihgtingNeed:Function;
      
      public var chooseVehicleRequest:Function;
      
      public var inviteFriendRequest:Function;
      
      public var toggleReadyStateRequest:Function;
      
      public var ignoreUserRequest:Function;
      
      public var editDescriptionRequest:Function;
      
      public var showFAQWindow:Function;
      
      private var _iRallyVO:IRallyVO;
      
      private var _array1:Array;
      
      private var _actionButtonVO:ActionButtonVO;
      
      private var _array2:Array;
      
      private var _tooltipDataVO:TooltipDataVO;
      
      public function BaseRallyRoomViewMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._iRallyVO)
         {
            this._iRallyVO.dispose();
            this._iRallyVO = null;
         }
         if(this._array1)
         {
            this._array1.splice(0,this._array1.length);
            this._array1 = null;
         }
         if(this._actionButtonVO)
         {
            this._actionButtonVO.dispose();
            this._actionButtonVO = null;
         }
         if(this._array2)
         {
            this._array2.splice(0,this._array2.length);
            this._array2 = null;
         }
         if(this._tooltipDataVO)
         {
            this._tooltipDataVO.dispose();
            this._tooltipDataVO = null;
         }
         super.onDispose();
      }
      
      public function assignSlotRequestS(param1:int, param2:Number) : void
      {
         App.utils.asserter.assertNotNull(this.assignSlotRequest,"assignSlotRequest" + Errors.CANT_NULL);
         this.assignSlotRequest(param1,param2);
      }
      
      public function leaveSlotRequestS(param1:Number) : void
      {
         App.utils.asserter.assertNotNull(this.leaveSlotRequest,"leaveSlotRequest" + Errors.CANT_NULL);
         this.leaveSlotRequest(param1);
      }
      
      public function onSlotsHighlihgtingNeedS(param1:Number) : Array
      {
         App.utils.asserter.assertNotNull(this.onSlotsHighlihgtingNeed,"onSlotsHighlihgtingNeed" + Errors.CANT_NULL);
         return this.onSlotsHighlihgtingNeed(param1);
      }
      
      public function chooseVehicleRequestS() : void
      {
         App.utils.asserter.assertNotNull(this.chooseVehicleRequest,"chooseVehicleRequest" + Errors.CANT_NULL);
         this.chooseVehicleRequest();
      }
      
      public function inviteFriendRequestS() : void
      {
         App.utils.asserter.assertNotNull(this.inviteFriendRequest,"inviteFriendRequest" + Errors.CANT_NULL);
         this.inviteFriendRequest();
      }
      
      public function toggleReadyStateRequestS() : void
      {
         App.utils.asserter.assertNotNull(this.toggleReadyStateRequest,"toggleReadyStateRequest" + Errors.CANT_NULL);
         this.toggleReadyStateRequest();
      }
      
      public function ignoreUserRequestS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.ignoreUserRequest,"ignoreUserRequest" + Errors.CANT_NULL);
         this.ignoreUserRequest(param1);
      }
      
      public function editDescriptionRequestS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.editDescriptionRequest,"editDescriptionRequest" + Errors.CANT_NULL);
         this.editDescriptionRequest(param1);
      }
      
      public function showFAQWindowS() : void
      {
         App.utils.asserter.assertNotNull(this.showFAQWindow,"showFAQWindow" + Errors.CANT_NULL);
         this.showFAQWindow();
      }
      
      public final function as_updateRally(param1:Object) : void
      {
         var _loc2_:IRallyVO = this._iRallyVO;
         this._iRallyVO = Boolean(param1) ? this.getIRallyVOForRally(param1) : null;
         this.updateRally(this._iRallyVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setMembers(param1:Boolean, param2:Array) : void
      {
         var _loc3_:Array = this._array1;
         this._array1 = param2;
         this.setMembers(param1,this._array1);
         if(_loc3_)
         {
            _loc3_.splice(0,_loc3_.length);
         }
      }
      
      public final function as_setMemberVehicle(param1:uint, param2:uint, param3:Object) : void
      {
         var _loc4_:VehicleVO = Boolean(param3) ? new VehicleVO(param3) : null;
         this.setMemberVehicle(param1,param2,_loc4_);
      }
      
      public final function as_setActionButtonState(param1:Object) : void
      {
         var _loc2_:ActionButtonVO = this._actionButtonVO;
         this._actionButtonVO = Boolean(param1) ? new ActionButtonVO(param1) : null;
         this.setActionButtonState(this._actionButtonVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_highlightSlots(param1:Array) : void
      {
         var _loc2_:Array = this._array2;
         this._array2 = param1;
         this.highlightSlots(this._array2);
         if(_loc2_)
         {
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      public final function as_setVehiclesTitle(param1:String, param2:Object) : void
      {
         var _loc3_:TooltipDataVO = this._tooltipDataVO;
         this._tooltipDataVO = new TooltipDataVO(param2);
         this.setVehiclesTitle(param1,this._tooltipDataVO);
         if(_loc3_)
         {
            _loc3_.dispose();
         }
      }
      
      protected function getIRallyVOForRally(param1:Object) : IRallyVO
      {
         var _loc2_:String = "getIRallyVOForRally" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function updateRally(param1:IRallyVO) : void
      {
         var _loc2_:String = "as_updateRally" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setMembers(param1:Boolean, param2:Array) : void
      {
         var _loc3_:String = "as_setMembers" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc3_);
         throw new AbstractException(_loc3_);
      }
      
      protected function setMemberVehicle(param1:uint, param2:uint, param3:VehicleVO) : void
      {
         var _loc4_:String = "as_setMemberVehicle" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc4_);
         throw new AbstractException(_loc4_);
      }
      
      protected function setActionButtonState(param1:ActionButtonVO) : void
      {
         var _loc2_:String = "as_setActionButtonState" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function highlightSlots(param1:Array) : void
      {
         var _loc2_:String = "as_highlightSlots" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setVehiclesTitle(param1:String, param2:TooltipDataVO) : void
      {
         var _loc3_:String = "as_setVehiclesTitle" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc3_);
         throw new AbstractException(_loc3_);
      }
   }
}
