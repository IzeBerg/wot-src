package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.techtree.data.ResearchPageVO;
   import net.wg.gui.lobby.techtree.data.ResearchRootVO;
   import net.wg.gui.lobby.techtree.data.vo.ResearchPostProgressionDataVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class ResearchMeta extends ResearchViewMeta
   {
       
      
      public var requestResearchData:Function;
      
      public var request4Unlock:Function;
      
      public var request4Rent:Function;
      
      public var goToNextVehicle:Function;
      
      public var exitFromResearch:Function;
      
      public var goToVehicleView:Function;
      
      public var compareVehicle:Function;
      
      public var onModuleHover:Function;
      
      public var goToPostProgression:Function;
      
      private var _researchPageVO:ResearchPageVO;
      
      private var _researchRootVO:ResearchRootVO;
      
      private var _array:Array;
      
      private var _researchPostProgressionDataVO:ResearchPostProgressionDataVO;
      
      public function ResearchMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._researchPageVO)
         {
            this._researchPageVO.dispose();
            this._researchPageVO = null;
         }
         if(this._researchRootVO)
         {
            this._researchRootVO.dispose();
            this._researchRootVO = null;
         }
         if(this._array)
         {
            this._array.splice(0,this._array.length);
            this._array = null;
         }
         if(this._researchPostProgressionDataVO)
         {
            this._researchPostProgressionDataVO.dispose();
            this._researchPostProgressionDataVO = null;
         }
         super.onDispose();
      }
      
      public function requestResearchDataS() : void
      {
         App.utils.asserter.assertNotNull(this.requestResearchData,"requestResearchData" + Errors.CANT_NULL);
         this.requestResearchData();
      }
      
      public function request4UnlockS(param1:int, param2:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.request4Unlock,"request4Unlock" + Errors.CANT_NULL);
         this.request4Unlock(param1,param2);
      }
      
      public function request4RentS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.request4Rent,"request4Rent" + Errors.CANT_NULL);
         this.request4Rent(param1);
      }
      
      public function goToNextVehicleS(param1:Number) : void
      {
         App.utils.asserter.assertNotNull(this.goToNextVehicle,"goToNextVehicle" + Errors.CANT_NULL);
         this.goToNextVehicle(param1);
      }
      
      public function exitFromResearchS() : void
      {
         App.utils.asserter.assertNotNull(this.exitFromResearch,"exitFromResearch" + Errors.CANT_NULL);
         this.exitFromResearch();
      }
      
      public function goToVehicleViewS(param1:Number) : void
      {
         App.utils.asserter.assertNotNull(this.goToVehicleView,"goToVehicleView" + Errors.CANT_NULL);
         this.goToVehicleView(param1);
      }
      
      public function compareVehicleS(param1:Number) : void
      {
         App.utils.asserter.assertNotNull(this.compareVehicle,"compareVehicle" + Errors.CANT_NULL);
         this.compareVehicle(param1);
      }
      
      public function onModuleHoverS(param1:Number) : void
      {
         App.utils.asserter.assertNotNull(this.onModuleHover,"onModuleHover" + Errors.CANT_NULL);
         this.onModuleHover(param1);
      }
      
      public function goToPostProgressionS(param1:Number) : void
      {
         App.utils.asserter.assertNotNull(this.goToPostProgression,"goToPostProgression" + Errors.CANT_NULL);
         this.goToPostProgression(param1);
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:ResearchPageVO = this._researchPageVO;
         this._researchPageVO = new ResearchPageVO(param1);
         this.setData(this._researchPageVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setRootData(param1:Object) : void
      {
         var _loc2_:ResearchRootVO = this._researchRootVO;
         this._researchRootVO = new ResearchRootVO(param1);
         this.setRootData(this._researchRootVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setInstalledItems(param1:Array) : void
      {
         var _loc2_:Array = this._array;
         this._array = param1;
         this.setInstalledItems(this._array);
         if(_loc2_)
         {
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      public final function as_setPostProgressionData(param1:Object) : void
      {
         var _loc2_:ResearchPostProgressionDataVO = this._researchPostProgressionDataVO;
         this._researchPostProgressionDataVO = new ResearchPostProgressionDataVO(param1);
         this.setPostProgressionData(this._researchPostProgressionDataVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:ResearchPageVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setRootData(param1:ResearchRootVO) : void
      {
         var _loc2_:String = "as_setRootData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setInstalledItems(param1:Array) : void
      {
         var _loc2_:String = "as_setInstalledItems" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setPostProgressionData(param1:ResearchPostProgressionDataVO) : void
      {
         var _loc2_:String = "as_setPostProgressionData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
