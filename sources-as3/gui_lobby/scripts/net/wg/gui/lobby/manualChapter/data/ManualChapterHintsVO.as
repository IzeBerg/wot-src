package net.wg.gui.lobby.manualChapter.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class ManualChapterHintsVO extends DAAPIDataClass
   {
      
      private static const HINTS:String = "hints";
       
      
      private var _hints:Vector.<ManualChapterHintVO>;
      
      public function ManualChapterHintsVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         for each(_loc1_ in this._hints)
         {
            _loc1_.dispose();
         }
         this._hints.splice(0,this._hints.length);
         this._hints = null;
         super.onDispose();
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Object = null;
         if(param1 == HINTS)
         {
            this._hints = new Vector.<ManualChapterHintVO>();
            for each(_loc3_ in param2)
            {
               this._hints.push(new ManualChapterHintVO(_loc3_));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      public function get hints() : Vector.<ManualChapterHintVO>
      {
         return this._hints;
      }
   }
}
