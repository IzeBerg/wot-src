package net.wg.gui.components.controls.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class TankmanTrainingSmallButtonVO extends DAAPIDataClass
   {
       
      
      public var isPremium:Boolean;
      
      public var gold:Number;
      
      public var credits:Number;
      
      public var baseRoleLoss:Number;
      
      public var classChangeRoleLoss:Number;
      
      public var roleLevel:Number;
      
      public function TankmanTrainingSmallButtonVO(param1:Object)
      {
         super(param1);
      }
   }
}
