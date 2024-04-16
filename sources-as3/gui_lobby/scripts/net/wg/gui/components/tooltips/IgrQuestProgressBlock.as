package net.wg.gui.components.tooltips
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.gui.components.tooltips.finstats.EfficiencyBlock;
   
   public class IgrQuestProgressBlock extends MovieClip
   {
       
      
      public var headerTF:TextField;
      
      public var valuesBlock:EfficiencyBlock;
      
      public function IgrQuestProgressBlock()
      {
         super();
      }
      
      public function setData(param1:String, param2:Array) : void
      {
         var _loc4_:int = 0;
         this.headerTF.htmlText = param1;
         var _loc3_:int = param2.length;
         var _loc5_:String = "";
         var _loc6_:String = "";
         var _loc7_:Array = null;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(_loc4_ > 0)
            {
               _loc5_ += "<br/>";
               _loc6_ += "<br/>";
            }
            _loc7_ = param2[_loc4_];
            _loc5_ += "<b>" + _loc7_[0] + "</b>/" + _loc7_[1];
            _loc6_ += _loc7_[2];
            _loc4_++;
         }
         this.valuesBlock.setData(_loc5_,_loc6_);
      }
   }
}
