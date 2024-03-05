package net.wg.gui.components.tooltips.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class SortieDivisionVO extends DAAPIDataClass
   {
       
      
      private var _divisions:Vector.<DivisionVO> = null;
      
      public function SortieDivisionVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Object = null;
         var _loc4_:DivisionVO = null;
         switch(param1)
         {
            case "divisions":
               this._divisions = new Vector.<DivisionVO>();
               for each(_loc3_ in param2)
               {
                  _loc4_ = new DivisionVO(_loc3_);
                  this._divisions.push(_loc4_);
               }
               return false;
            default:
               return true;
         }
      }
      
      override protected function onDispose() : void
      {
         if(this._divisions)
         {
            this.cleanData();
            this._divisions = null;
         }
         super.onDispose();
      }
      
      private function cleanData() : void
      {
         var _loc1_:DivisionVO = null;
         for each(_loc1_ in this._divisions)
         {
            _loc1_.dispose();
         }
         this._divisions.splice(0,this._divisions.length);
      }
      
      public function get divisions() : Vector.<DivisionVO>
      {
         return this._divisions;
      }
      
      public function set divisions(param1:Vector.<DivisionVO>) : void
      {
         this._divisions = param1;
      }
   }
}
