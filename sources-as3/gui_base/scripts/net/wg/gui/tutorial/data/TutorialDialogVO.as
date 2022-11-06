package net.wg.gui.tutorial.data
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.data.WaitingQueueWindowVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class TutorialDialogVO extends WaitingQueueWindowVO
   {
      
      private static const BONUSES_FIELD_NAME:String = "bonuses";
      
      private static const BONUSES_DATA_ASSERT_MESSGAE:String = BONUSES_FIELD_NAME + Errors.CANT_NULL;
       
      
      public var avgTimeText:String = "";
      
      public var checkBoxLabel:String = "";
      
      public var doStartOnNextLogin:Boolean;
      
      public var imageUrl:String = "";
      
      public var timeNoteValue:String = "";
      
      public var align:String = "";
      
      public var submitLabel:String = "";
      
      public var offsetX:int = -1;
      
      public var offsetY:int = -1;
      
      public var bonuses:Vector.<BonusItemVO>;
      
      public function TutorialDialogVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(param1 == BONUSES_FIELD_NAME)
         {
            _loc3_ = param2 as Array;
            App.utils.asserter.assert(_loc3_ != null,BONUSES_DATA_ASSERT_MESSGAE);
            _loc4_ = _loc3_.length;
            this.bonuses = new Vector.<BonusItemVO>(_loc4_,true);
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               this.bonuses[_loc5_] = new BonusItemVO(_loc3_[_loc5_]);
               _loc5_++;
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         if(this.bonuses != null)
         {
            for each(_loc1_ in this.bonuses)
            {
               _loc1_.dispose();
            }
            this.bonuses.fixed = false;
            this.bonuses.splice(0,this.bonuses.length);
            this.bonuses = null;
         }
         super.onDispose();
      }
   }
}
