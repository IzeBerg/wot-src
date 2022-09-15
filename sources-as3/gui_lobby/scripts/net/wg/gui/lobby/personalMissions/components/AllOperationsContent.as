package net.wg.gui.lobby.personalMissions.components
{
   import net.wg.gui.lobby.personalMissions.data.OperationDataVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class AllOperationsContent extends UIComponentEx
   {
       
      
      public var operation1:OperationButton = null;
      
      public var operation2:OperationButton = null;
      
      public var operation3:OperationButton = null;
      
      public var operation4:OperationButton = null;
      
      public var operation5:OperationButton = null;
      
      public var operation6:OperationButton = null;
      
      public var operation7:OperationButton = null;
      
      private var _operations:Vector.<OperationDataVO> = null;
      
      private var _operationBtns:Vector.<OperationButton> = null;
      
      private var _operationsBtnLen:int = 0;
      
      public function AllOperationsContent()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._operationBtns = new <OperationButton>[this.operation1,this.operation2,this.operation3,this.operation4,this.operation5,this.operation6,this.operation7];
         this._operationsBtnLen = this._operationBtns.length;
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.draw();
         if(this._operations && isInvalid(InvalidationType.DATA))
         {
            _loc1_ = this._operations.length;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               this._operationBtns[_loc2_].enabled = _loc2_ < this._operationsBtnLen;
               this._operationBtns[_loc2_].data = this._operations[_loc2_];
               _loc2_++;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:int = this._operationBtns.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            this._operationBtns[_loc2_] = null;
            _loc2_++;
         }
         this._operationBtns.splice(0,_loc1_);
         this._operationBtns = null;
         this.operation1.dispose();
         this.operation1 = null;
         this.operation2.dispose();
         this.operation2 = null;
         this.operation3.dispose();
         this.operation3 = null;
         this.operation4.dispose();
         this.operation4 = null;
         this.operation5.dispose();
         this.operation5 = null;
         this.operation6.dispose();
         this.operation6 = null;
         this.operation7.dispose();
         this.operation7 = null;
         this._operations = null;
         super.onDispose();
      }
      
      public function setOperations(param1:Vector.<OperationDataVO>) : void
      {
         this._operations = param1;
         invalidateData();
      }
   }
}
