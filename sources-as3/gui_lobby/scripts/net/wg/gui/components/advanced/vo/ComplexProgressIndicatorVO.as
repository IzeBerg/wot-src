package net.wg.gui.components.advanced.vo
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.lobby.referralSystem.data.ProgressStepVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class ComplexProgressIndicatorVO extends DAAPIDataClass
   {
      
      private static const STEPS:String = "steps";
       
      
      public var progress:Number = 0;
      
      public var text:String = "";
      
      public var steps:Vector.<ProgressStepVO> = null;
      
      public var rendererClassLinkage:String = "";
      
      public function ComplexProgressIndicatorVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:ProgressStepVO = null;
         var _loc5_:Object = null;
         if(param1 == STEPS)
         {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,"steps" + Errors.CANT_NULL);
            this.steps = new Vector.<ProgressStepVO>();
            _loc4_ = null;
            for each(_loc5_ in _loc3_)
            {
               _loc4_ = new ProgressStepVO(_loc5_);
               this.steps.push(_loc4_);
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         for each(_loc1_ in this.steps)
         {
            _loc1_.dispose();
         }
         this.steps.splice(0,this.steps.length);
         this.steps = null;
         super.onDispose();
      }
   }
}
