package net.wg.gui.components.advanced.vo
{
   import net.wg.data.constants.Errors;
   
   public class TutorialContextOverlayVO extends TutorialContextVO
   {
      
      private static const HINTS:String = "hints";
      
      private static const BTN_CONTROLLER_VO:String = "btnControllerVo";
       
      
      public var hintID:String = "";
      
      public var hints:Vector.<TutorialContextHintVO> = null;
      
      public var btnControllerVo:TutorialBtnControllerVO = null;
      
      public function TutorialContextOverlayVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:TutorialContextHintVO = null;
         if(this.hints != null)
         {
            for each(_loc1_ in this.hints)
            {
               _loc1_.dispose();
            }
            this.hints.splice(0,this.hints.length);
            this.hints = null;
         }
         if(this.btnControllerVo != null)
         {
            this.btnControllerVo.dispose();
            this.btnControllerVo = null;
         }
         super.onDispose();
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         var _loc5_:TutorialContextHintVO = null;
         if(param1 == HINTS)
         {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,"items" + Errors.CANT_NULL);
            this.hints = new Vector.<TutorialContextHintVO>();
            for each(_loc4_ in _loc3_)
            {
               _loc5_ = new TutorialContextHintVO(_loc4_);
               this.hints.push(_loc5_);
            }
            return false;
         }
         if(param1 == BTN_CONTROLLER_VO)
         {
            this.btnControllerVo = new TutorialBtnControllerVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
   }
}
